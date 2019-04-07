//
//  CreateReviewViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-18.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class CreateReviewViewController: UIViewController, IconSelectorDelegate {
    // MARK: Constants
    static let modalSegueIdentifier = "ShowReviewCreatorFromReviewablePageSegueIdentifier"
    static let kSelectedEmojiNotification = NSNotification.Name(rawValue: "kSelectedEmojiNotification")
    let keyboardAnimationDuration = 0.5
    
    // MARK: Properties
    var reviewable: Reviewable?
    var selectedEmoji: String? {
        didSet {
            if let emoji = selectedEmoji {
                emojiImageView?.image = UIImage(named: emoji + "Emoji")
            } else {
                emojiImageView?.image = nil
            }
        }
    }
    
    // MARK: Outlets
    @IBOutlet weak var reviewableImageView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var emojiImageView: UIImageView!
    @IBOutlet weak var emojiSelectorButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        let iconSelectorViewController = self.childViewControllers.last as! IconSelectorViewController
        iconSelectorViewController.delegate = self
        
        if let r = reviewable {
            detailsLabel?.text = r.description
            
            if let imageUrl = r.titleImageUrl {
                self.reviewableImageView?.image = UIImage.image(from: imageUrl)
            }
        }
    }
    
    func setReviewable(reviewable: Reviewable) {
        self.reviewable = reviewable
        self.title = reviewable.title
    }
    
    @IBAction func save(_ sender: Any) {
        guard let reviewable = self.reviewable,
              let emoji = selectedEmoji
        else {
            return
        }
        
        if let apiUser = AppUserAPIService.shared.currentUser {
            let review = Review(emojis: emoji, comment: self.commentTextView?.text, appUser: apiUser, reviewable: reviewable)
            ReviewAPIService.shared.create(review: review).then { review in
                //TODO: show success
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            SessionService.shared.forcedLogout()
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func emojiSelectorButtonPress(_ sender: Any) {
        self.commentTextView.resignFirstResponder()
    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        UIView.animate(withDuration: keyboardAnimationDuration, animations: {
            if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardHeight = keyboardFrame.cgRectValue.height
                self.emojiSelectorButtonBottomConstraint.constant = keyboardHeight
            } else {
                self.emojiSelectorButtonBottomConstraint.constant = 300
            }
            
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: keyboardAnimationDuration, animations: {
            self.emojiSelectorButtonBottomConstraint.constant = -45
            self.view.layoutIfNeeded()
        })
    }
    
    func iconSelector(_ selector: UICollectionViewController, didSelectEmoji emoji: String) {
        selectedEmoji = emoji
    }
}
