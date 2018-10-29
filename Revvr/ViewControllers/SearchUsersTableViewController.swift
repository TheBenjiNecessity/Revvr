//
//  SearchUsersTableViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-15.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

extension SearchUsersTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class SearchUsersTableViewController: UsersListTableViewController {
    let searchController = UISearchController(searchResultsController: nil)

    var debounceTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Users"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        debounceTimer?.invalidate()
        let nextTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            AppUserAPIService.shared.search(text: searchText).then({ (users) in
                self.users = users
                self.tableView.reloadData()
            })
        }
        debounceTimer = nextTimer
    }
}
