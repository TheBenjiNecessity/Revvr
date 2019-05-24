//
//  ReviewTableViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-23.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit
import Promises

class ReviewTableViewController: UITableViewController, ReviewActionsDelegate {
    let reuseIdentifiers = [
        ReviewTableViewCell.reuseIdentifier,
        ReviewStatsTableViewCell.reuseIdentifier,
        ReviewActionsTableViewCell.reuseIdentifier
    ]
    
    var review = Review()
    var like:ReviewLike?
    var replies: [ReviewReply] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        ReviewAPIService.shared.listReplies(id: review.id).then { replies in
            self.replies = replies
            if let currentUser = AppUserAPIService.shared.currentUser, self.review.appUserID != currentUser.id {
                ReviewAPIService.shared.getLike(id: self.review.id, appUserId: self.review.appUserID).then { like in
                    self.like = like
                    self.tableView?.reloadData()
                }.catch { error in
                    self.tableView?.reloadData()
                }
            } else {
                self.tableView?.reloadData()
            }
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
        let ppHeight = CGFloat(44.0)
        let margin = CGFloat(5.0)
        if indexPath.row == 0 {
            let commentHeight = review.comment?.height(withConstrainedWidth: tableView.frame.size.width, font: UIFont.systemFont(ofSize: CGFloat(17.0))) ?? 0
            let rImageHeight = CGFloat(90.0)
            return margin + ppHeight + margin + rImageHeight + margin + commentHeight + margin
        } else if indexPath.row > 0 && indexPath.row <= 2 {
            return ppHeight
        } else {
            let reply = replies[indexPath.row - reuseIdentifiers.count]
            let commentHeight = reply.comment.height(withConstrainedWidth: tableView.frame.size.width, font: UIFont.systemFont(ofSize: CGFloat(17.0)))
            return margin + ppHeight + margin + commentHeight + margin
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
                if let like = self.like {
                    (cell as! ReviewActionsTableViewCell).like = like
                }
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
        self.performSegue(withIdentifier: "CreateReplySegueIdentifier", sender: nil)
    }
    
    func reviewActionCellDidPressAgree() -> Promise<ReviewLike> {
        return self.reviewLike(forType: "agree")
    }
    
    func reviewActionCellDidPressDisagree() -> Promise<ReviewLike> {
        return self.reviewLike(forType: "disagree")
    }
    
    func reviewActionCellDidPressExtras() {
        print("extras")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let rrmvc = nav.topViewController as! ReviewReplyModalViewController
        rrmvc.review = review
    }
    
    func reviewLike(forType type: String) -> Promise<ReviewLike> {
        guard let userId = AppUserAPIService.shared.currentUser?.id else {
            let error = NSError(domain: "Set like error", code: -1, userInfo: nil)
            return Promise<ReviewLike> { fulfill, reject in reject(error); }
        }
        
        let reviewId = review.id
        let reviewLike = ReviewLike(appUserID: userId, reviewID: reviewId, type: type, created: nil)
        
        return ReviewAPIService.shared.like(reviewLike: reviewLike).then { like in
            self.like = like
            self.tableView?.reloadData()
        }
    }
}
