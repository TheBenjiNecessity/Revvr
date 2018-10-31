//
//  SearchUsersTableViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-15.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

extension SearchTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class SearchTableViewController: UITableViewController {
    let searchController = UISearchController(searchResultsController: nil)
    var debounceTimer: Timer?
    
    var models: [Any] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Users & Products"
        searchController.searchBar.scopeButtonTitles = ["Users", "Products", "Media", "Events", "Services"]
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
    }
    
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
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        debounceTimer?.invalidate()
        let nextTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            AppUserAPIService.shared.search(text: searchText).then { users in
                self.models = users
                self.tableView.reloadData()
            }
        }
        debounceTimer = nextTimer
    }
}
