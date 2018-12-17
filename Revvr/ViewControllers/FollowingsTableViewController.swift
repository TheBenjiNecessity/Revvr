//
//  FollowingsTableViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-12-16.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit
import Promises

enum FollowType {
    case followers
    case followings
}

class FollowingsTableViewController: UITableViewController, FollowDelegate {
    var user: AppUser = AppUser()
    var followings: [AppUser] = [] { didSet { self.tableView?.reloadData() } }
    var followType: FollowType = .followers

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        if followType == .followers {
            AppUserAPIService.shared.listFollowers(id: user.id).then { users in self.followings = users }
        } else {
            AppUserAPIService.shared.listFollowings(id: user.id).then { users in self.followings = users }
        }
    }
    
    func set(followType type: FollowType, for user: AppUser) {
        self.user = user
        self.followType = type
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FollowingTableViewCell.reuseIdentifier, for: indexPath) as! FollowingTableViewCell
        
        cell.user = followings[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(54.0) //TODO remove magic number
    }
    
    func follow(user: AppUser) -> Promise<AppUserFollowing> {
        return AppUserAPIService.shared.add(followingId: user.id)
    }
    
    func unFollow(user: AppUser) -> Promise<AppUserFollowing> {
        return AppUserAPIService.shared.delete(followingId: user.id)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
