//
//  CreateReviewViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-18.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class CreateReviewViewController: UIViewController {
    var reviewable: Reviewable?
    
    static let modalSegueIdentifier = "ShowReviewCreatorFromReviewablePageSegueIdentifier"
    
    @IBOutlet weak var reviewableImageView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let r = reviewable {
            detailsLabel?.text = r.description
            reviewableImageView?.image = UIImage.imageFrom(urlString: r.titleImageUrl)
        }
    }
    
    func setReviewable(reviewable: Reviewable) {
        self.reviewable = reviewable
        self.title = reviewable.title
    }
    
    @IBAction func save(_ sender: Any) {
        if let reviewable = self.reviewable, let user = SessionService.shared.user {
            let review = Review(emojis: "", comment: "", appUser: user, reviewable: reviewable)
            ReviewAPIService.shared.create(review: review).then { review in
                //TODO: show success
                //self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
