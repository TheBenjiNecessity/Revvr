//
//  UserDetailsView.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-06-02.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

@IBDesignable
class UserDetailsView: UIView {
    lazy var profilePictureImageView: UIImageView = {
        let ppImage = UIImage(named: "DefaultProfilePictureThumbnail")
        let ppView = UIImageView(image: ppImage)
        ppView.translatesAutoresizingMaskIntoConstraints = false
        ppView.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        return ppView
    }()
    
    lazy var userDetailsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.text = "Username"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 44, y: 0, width: 100, height: 44)
        
        return label
    }()

    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(profilePictureImageView)
        addSubview(userDetailsLabel)
        
        let views: [String: Any] = ["ppview": profilePictureImageView, "udview": userDetailsLabel]
        var allConstraints: [NSLayoutConstraint] = []
        
        let subviewVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[ppview(44)]",
                                                                        options: [],
                                                                        metrics: nil,
                                                                        views: views)
        allConstraints += subviewVerticalConstraints
        
        allConstraints += [NSLayoutConstraint(item: profilePictureImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: CGFloat(1), constant: 0)]
        
        let subviewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[ppview(44)]-8-[udview]-0-|",
                                                                          options: [.alignAllTop, .alignAllBottom],
                                                                          metrics: nil,
                                                                          views: views)
        allConstraints += subviewHorizontalConstraints
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    func setUserDetails(user: AppUser) {
        //profilePictureImageView.image = UIImage.image(from: user.blah)
        userDetailsLabel.attributedText = NSAttributedString.attributedStringFor(user: user, of: CGFloat(15.0))
    }
}
