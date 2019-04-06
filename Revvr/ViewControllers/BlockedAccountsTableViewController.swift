//
//  BlockedAccountsTableViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-04-03.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

class BlockedAccountsTableViewController: UITableViewController {
    var users: [AppUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()

        AppUserAPIService.shared.listBlockings().then { users in
            self.users = users
            self.tableView?.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlockedUserCellIdentifier", for: indexPath) as! UserTableViewCell

        cell.setModel(model: users[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserTableViewCell.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowUserSequeIdentifier", sender: users[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        showUserSettingsActionSheet(forUser: users[indexPath.row])
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let user = sender as! AppUser
        let destination = segue.destination as! UserWithReviewsCollectionViewController
        destination.user = user
    }
    
    func showUserSettingsActionSheet(forUser user: AppUser) {
        let userSettingsMenu = UIAlertController(title: "User Options", message: nil, preferredStyle: .actionSheet)
        
        let unBlockAction = UIAlertAction(title: "Unblock", style: .default) { action in
            AppUserAPIService.shared.unblock(blockingId: user.id).then{_ in
                
            }.catch { error in
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        userSettingsMenu.addAction(unBlockAction)
        userSettingsMenu.addAction(cancelAction)
        
        self.present(userSettingsMenu, animated: true, completion: nil)
    }
}
