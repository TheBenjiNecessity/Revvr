//
//  SearchUsersTableViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-15.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit
import Promises

extension SearchTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
        
        // Set the helper text to show in the footer
        let index = self.searchController.searchBar.selectedScopeButtonIndex
        if let selectedSectionText = searchController.searchBar.scopeButtonTitles?[index] {
            footerLabel?.text = sectionSearchHelperTexts[selectedSectionText.lowercased()]
        }
    }
}

class SearchTableViewController: UITableViewController {
    let searchController = UISearchController(searchResultsController: nil)
    var debounceTimer: Timer?
    
    var models: [Any] = []
    
    let sectionSearchHelperTexts = [
        "users": "Search for users",
        "media": "Search for movies and tv shows",
        "products": "Search for products",
    ]
    
    @IBOutlet weak var footerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        footerLabel?.text = sectionSearchHelperTexts["users"]
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Users & Products"
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let identifier = model is AppUser ? UserTableViewCell.reuseIdentifier : ReviewableTableViewCell.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ModelTableViewCell
        
        cell.setModel(model: model)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return models[indexPath.row] is AppUser ? UserTableViewCell.cellHeight : ReviewableTableViewCell.cellHeight
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        if case let user = model, model is AppUser {
            self.performSegue(withIdentifier: "ShowUserSequeIdentifier", sender: user)
        } else if case let reviewable = model, model is Reviewable {
            self.performSegue(withIdentifier: "ShowReviewableSequeIdentifier", sender: reviewable)
        }
    }
    
    // MARK: - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is AppUser {
            let uvc = segue.destination as! UserWithReviewsCollectionViewController
            uvc.user = sender as! AppUser
        } else if sender is Reviewable {
            let rvc = segue.destination as! ReviewableWithReviewsCollectionViewController
            rvc.setReviewable(reviewable: sender as! Reviewable)
        }
    }
    
    // MARK: - Search bar delegate methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        debounceTimer?.invalidate()
        let nextTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            all(
                AppUserAPIService.shared.search(text: searchText),
                ReviewableAPIService.shared.search(text: searchText, type: "media")
            ).then { users, reviewables in
                self.models = users + reviewables
                self.tableView.reloadData()
            }
        }
        debounceTimer = nextTimer
    }
}
