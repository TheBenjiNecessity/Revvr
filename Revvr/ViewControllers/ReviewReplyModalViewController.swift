//
//  ReviewReplyModalViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-12-01.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class ReviewReplyModalViewController: UIViewController {
    var review = Review()
    
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsLabel?.text = "Replying to @\(review.appUser.handle)'s review of \(review.reviewable.title)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        commentTextView?.becomeFirstResponder()
    }
    
    @IBAction func save(_ sender: Any) {
        if let comment = commentTextView?.text {
            AppUserAPIService.shared.getApiUser().then { apiUser in
                let reviewReply = ReviewReply(appUserID: apiUser.id, reviewID: self.review.id, comment: comment)
                ReviewAPIService.shared.reply(reply: reviewReply).then { reply in
                    //TODO: show success
                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
