//
//  ReviewActionsTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-23.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

protocol ReviewActionsDelegate: AnyObject {
    func reviewActionCellDidPressReply()
    func reviewActionCellDidPressAgree()
    func reviewActionCellDidPressExtras()
}

class ReviewActionsTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ReviewActionsTableViewCellIdentifier"
    
    weak var delegate: ReviewActionsDelegate?

    @IBAction func replyPress(_ sender: Any) {
        delegate?.reviewActionCellDidPressReply()
    }
    
    @IBAction func agreePress(_ sender: Any) {
        delegate?.reviewActionCellDidPressAgree()
    }
    
    @IBAction func extrasPress(_ sender: Any) {
        delegate?.reviewActionCellDidPressExtras()
    }
}
