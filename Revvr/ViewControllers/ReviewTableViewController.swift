//
//  ReviewTableViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-23.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class ReviewTableViewController: UITableViewController, ReviewActionsDelegate {
    let reuseIdentifiers = [
        ReviewTableViewCell.reuseIdentifier,
        ReviewStatsTableViewCell.reuseIdentifier,
        ReviewActionsTableViewCell.reuseIdentifier
    ]
    
    var review = Review()
    var replies: [ReviewReply] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        ReviewAPIService.shared.listReplies(id: review.id!).then { replies in
            self.replies = replies
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Since the first three cells are 'review' cells, this needs to be offset
        return reuseIdentifiers.count + replies.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200 //+ height of comment label?
        } else if indexPath.row > 0 && indexPath.row <= 2 {
            return 44
        } else {
            return 120
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reuseIdentifier = ReviewReplyTableViewCell.reuseIdentifier
        if indexPath.row <= (reuseIdentifiers.count - 1) {
            reuseIdentifier = reuseIdentifiers[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        switch cell {
            case is ReviewTableViewCell:
                (cell as! ReviewTableViewCell).setReview(review: self.review)
            case is ReviewActionsTableViewCell:
                (cell as! ReviewActionsTableViewCell).delegate = self
            case is ReviewStatsTableViewCell:
                (cell as! ReviewStatsTableViewCell).setStats(review: self.review)
            default: // as reply
                let replyCell = cell as! ReviewReplyTableViewCell
                replyCell.setReply(reply: replies[indexPath.row - reuseIdentifiers.count])
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func reviewActionCellDidPressReply() {
        print("reply")
        self.performSegue(withIdentifier: "CreateReplySegueIdentifier", sender: nil)
    }
    
    func reviewActionCellDidPressAgree() {
        print("agree")
    }
    
    func reviewActionCellDidPressExtras() {
        print("extras")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let rrmvc = nav.topViewController as! ReviewReplyModalViewController
        rrmvc.review = review
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
