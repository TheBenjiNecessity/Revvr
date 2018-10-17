//
//  FrontViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-15.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

// This is the view the user sees when they first start the app and they aren't logged in

import UIKit

enum viewState {
    case Front
    case Login
    case Signup
}

class FrontViewController: UIViewController {
    private var _state: viewState = viewState.Front
    
    var state: viewState {
        get { return _state }
        set {
            _state = newValue
            
            switch state {
            case .Front:
                loginContainerView.isHidden = true
                signupContainerView.isHidden = true
                reLabel.isHidden = false
                reviewEverythingLabel.isHidden = false
                goButton.isHidden = true
                cancelButton.isHidden = true
                navigationController?.setNavigationBarHidden(true, animated: true)
                break
            case .Signup:
                loginContainerView.isHidden = true
                signupContainerView.isHidden = false
                reLabel.isHidden = true
                reviewEverythingLabel.isHidden = true
                signupFirstNameField.becomeFirstResponder()
                goButton.isHidden = false
                cancelButton.isHidden = false
                goButton.setTitle("Sign Up", for: .normal) //TODO: translate
                buttonContstraint.isActive = true
                navigationController?.setNavigationBarHidden(false, animated: true)
                break
            case .Login:
                loginContainerView.isHidden = false
                signupContainerView.isHidden = true
                reLabel.isHidden = true
                reviewEverythingLabel.isHidden = true
                loginUsernameField.becomeFirstResponder()
                goButton.isHidden = false
                cancelButton.isHidden = false
                goButton.setTitle("Login", for: .normal) //TODO: translate
                buttonContstraint.isActive = false
                navigationController?.setNavigationBarHidden(false, animated: true)
                break
            }
        }
    }
    
    @IBOutlet weak var loginContainerView: UIView!
    @IBOutlet weak var loginUsernameField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    
    @IBOutlet weak var signupContainerView: UIView!
    @IBOutlet weak var signupFirstNameField: UITextField!
    @IBOutlet weak var signupLastNameField: UITextField!
    @IBOutlet weak var signupUserNameField: UITextField!
    @IBOutlet weak var signupEmailField: UITextField!
    @IBOutlet weak var signupPasswordField: UITextField!
    
    @IBOutlet weak var reLabel: UILabel!
    @IBOutlet weak var reviewEverythingLabel: UILabel!
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet var buttonContstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        initStyles()
        state = .Front
    }
    
    @IBAction func loginPress(_ sender: Any) {
        state = .Login
    }
    
    @IBAction func signUpPress(_ sender: Any) {
        state = .Signup
    }
    
    @IBAction func cancelButtonPress(_ sender: Any) {
        view.endEditing(true)
        state = .Front
    }
    
    @IBAction func goButtonPress(_ sender: Any) {
        switch state {
        case .Front:
            break
        case .Signup:
            break
        case .Login:
            break
        }
    }

    func initStyles() {
        loginContainerView.layer.cornerRadius = 5.0
        signupContainerView.layer.cornerRadius = 5.0
    }
}
