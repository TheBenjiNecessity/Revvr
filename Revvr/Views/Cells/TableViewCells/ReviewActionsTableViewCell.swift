//
//  ReviewActionsTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-23.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit
import Promises

protocol ReviewActionsDelegate: AnyObject {
    func reviewActionCellDidPressReply()
    func reviewActionCellDidPressAgree() -> Promise<ReviewLike>
    func reviewActionCellDidPressDisagree() -> Promise<ReviewLike>
    func reviewActionCellDidPressExtras()
}

class ReviewActionsTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ReviewActionsTableViewCellIdentifier"
    static let likeSelectedImageName = "outline_thumb_up_black_24pt"
    static let dislikeSelectedImageName = "outline_thumb_down_black_24pt"
    static let likeImageName = "baseline_thumb_up_black_24pt"
    static let dislikeImageName = "baseline_thumb_down_black_24pt"
    
    weak var delegate: ReviewActionsDelegate?
    var like: ReviewLike?
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    
    let likeSelectedImage = UIImage(named: likeSelectedImageName)
    let dislikeSelectedImage = UIImage(named: dislikeSelectedImageName)
    let likeImage = UIImage(named: likeImageName)
    let dislikeImage = UIImage(named: dislikeImageName)
    
    func disableLikeButtons(disable: Bool) {
        likeButton.tintColor = disable ? UIColor.disableTintColor : UIColor.tintColor
        dislikeButton.tintColor = disable ? UIColor.disableTintColor : UIColor.tintColor
        likeButton.isEnabled = !disable
        dislikeButton.isEnabled = !disable
    }

    @IBAction func replyPress(_ sender: Any) {
        delegate?.reviewActionCellDidPressReply()
    }
    
    @IBAction func agreePress(_ sender: Any) {
        likeButton.setImage(likeSelectedImage, for: .normal)
        dislikeButton.setImage(dislikeImage, for: .normal)
        delegate?.reviewActionCellDidPressAgree().then {_ in }.catch { error in
            self.likeButton.setImage(self.likeImage, for: .normal)
            if let like = self.like, like.type == "disagree" {
                self.dislikeButton.setImage(self.dislikeSelectedImage, for: .normal)
            }
        }
    }
    
    @IBAction func disagreePress(_ sender: Any) {
        likeButton.setImage(likeImage, for: .normal)
        dislikeButton.setImage(dislikeSelectedImage, for: .normal)
        delegate?.reviewActionCellDidPressDisagree().then {_ in }.catch { error in
            self.dislikeButton.setImage(self.dislikeImage, for: .normal)
            if let like = self.like, like.type == "agree" {
                self.likeButton.setImage(self.likeSelectedImage, for: .normal)
            }
        }
    }
    
    @IBAction func extrasPress(_ sender: Any) {
        delegate?.reviewActionCellDidPressExtras()
    }
}
