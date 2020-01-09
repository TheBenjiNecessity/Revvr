//
//  UserDetailsView.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-06-02.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

protocol UserDetailsViewDelegate: AnyObject {
    func didTap(with user: AppUser)
}

class UserDetailsView: UIView {
    weak var delegate: UserDetailsViewDelegate?
    
    @IBInspectable var textColor : UIColor? {
        set (newValue) {
            userDetailsLabel.textColor = newValue ?? UIColor.black
        }
        get {
            return userDetailsLabel.textColor
        }
    }
    
    var user = AppUser()
    var shouldAllowTap = false
    
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
        setupView(height: 44)
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView(height: 44)
    }
    
    private func setupView(height: Int) {
        translatesAutoresizingMaskIntoConstraints = false
        
        profilePictureImageView.removeConstraints(profilePictureImageView.constraints)
        userDetailsLabel.removeConstraints(userDetailsLabel.constraints)
        profilePictureImageView.removeFromSuperview()
        userDetailsLabel.removeFromSuperview()
        
        addSubview(profilePictureImageView)
        addSubview(userDetailsLabel)
        
        let views: [String: Any] = ["ppview": profilePictureImageView, "udview": userDetailsLabel]
        var allConstraints: [NSLayoutConstraint] = []
        
        let subviewVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[ppview(\(height))]",
                                                                        options: [],
                                                                        metrics: nil,
                                                                        views: views)
        allConstraints += subviewVerticalConstraints
        
        allConstraints += [NSLayoutConstraint(item: profilePictureImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: CGFloat(1), constant: 0)]
        
        let subviewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[ppview(\(height))]-8-[udview]-0-|",
                                                                          options: [.alignAllTop, .alignAllBottom],
                                                                          metrics: nil,
                                                                          views: views)
        allConstraints += subviewHorizontalConstraints
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    func setUserDetails(user: AppUser, fontSize: CGFloat = CGFloat(15)) {
        self.user = user
        
        //profilePictureImageView.image = UIImage.image(from: user.blah)
        userDetailsLabel.attributedText = NSAttributedString.attributedStringFor(user: user, of: fontSize)
    }
    
    func setImage(height: Int) {
        self.setupView(height: height)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if shouldAllowTap {
            delegate?.didTap(with: self.user)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if shouldAllowTap {
            //TODO show highlight
        }
    }
}
