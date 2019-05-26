//
//  SignUpViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-03-29.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, TappableLabelDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    
    @IBOutlet weak var signUpContainerView: UIView!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var signInLabel: TappableLabel!
    
    @IBOutlet weak var usernameWarningLabel: UILabel!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    @IBOutlet weak var emailWarningLabel: UILabel!
    @IBOutlet weak var firstnameWarningLabel: UILabel!
    @IBOutlet weak var lastnameWarningLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signInLabel.delegate = self
        
        signUpContainerView.layer.cornerRadius = 5.0
    }

    @IBAction func signUpButtonPress(_ sender: Any) {
        showLoading(loading: true)
        
        guard let username = usernameField.text, username != "" else {
            usernameWarningLabel.isHidden = false
            self.showInputError(message: "Please enter a user name")
            return
        }
        
        guard let password = passwordField.text, password != "" else {
            passwordWarningLabel.isHidden = false
            self.showInputError(message: "Please enter a password")
            return
        }
        
        guard let email = emailField.text, email != "" else {
            emailWarningLabel.isHidden = false
            self.showInputError(message: "Please enter an email")
            return
        }
        
        guard let firstname = firstnameField.text, firstname != "" else {
            firstnameWarningLabel.isHidden = false
            self.showInputError(message: "Please enter a first name")
            return
        }
        
        guard let lastname = lastnameField.text, lastname != "" else {
            lastnameWarningLabel.isHidden = false
            self.showInputError(message: "Please enter a last name")
            return
        }
        
        signup(withUsername: username, password: password, email: email, firstname: firstname, lastname: lastname)
    }
    
    func showInputError(message: String? = nil) {
        self.showLoading(loading: false)
        
        guard let message = message else {
            usernameWarningLabel.isHidden = true
            passwordWarningLabel.isHidden = true
            signUpContainerView.layer.borderColor = UIColor.clear.cgColor
            signUpContainerView.layer.borderWidth = 0.0
            warningLabel.text = ""
            return
        }
        
        signUpContainerView.layer.borderColor = UIColor.red.cgColor
        signUpContainerView.layer.borderWidth = 1.0
        warningLabel.text = message
    }
    
    func showLoading(loading: Bool) {
        if loading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func signup(withUsername username: String,
                             password: String,
                             email: String,
                             firstname: String,
                             lastname: String) {
        let user = AppUser(id: -1, firstName: firstname, lastName: lastname, handle: username, email: email, password: password)
        AppUserAPIService.shared.create(user: user).then { user in
            self.presentingViewController?.dismiss(animated: true, completion: {
                if let loginViewController = self.presentingViewController as? LoginViewController {
                    loginViewController.goToHomePage(animated: true)
                }
            })
        }.catch { error in
            self.showInputError(message: "Could not create new user")
        }
    }
    
    func touchUpInside() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
