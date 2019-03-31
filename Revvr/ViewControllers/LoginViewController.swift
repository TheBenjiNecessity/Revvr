//
//  LoginViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-03-28.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, TappableLabelDelegate {
    let LoggedInNoAnimationSegueIdentifier = "LoggedInNoAnimationSegueIdentifier"
    let LoggedInSegueIdentifier = "LoggedInSegueIdentifier"
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpLabel: TappableLabel!
    @IBOutlet weak var loginContainerView: UIView!
    @IBOutlet weak var usernameWarningLabel: UILabel!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If the user is logged in then go straight to the home page
        if SessionService.shared.isLoggedIn() {
            self.goToHomePage(animated: false)
        } else {
            signUpLabel.delegate = self
            usernameTextField.delegate = self
            passwordTextField.delegate = self
            
            loginContainerView.layer.cornerRadius = 5.0
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    @IBAction func signInButtonPress(_ sender: Any) {
        self.showLoading(loading: true)
        guard let username = usernameTextField.text, username != "" else {
            self.showUsernameError(message: "Please enter a user name")
            return
        }
        
        guard let password = passwordTextField.text, password != "" else {
            self.showPasswordError(message: "Please enter a password")
            return
        }
        
        self.login(withUsername: username, password: password)
    }
    
    func showUsernameError(message: String) {
        usernameWarningLabel.isHidden = false
        self.showInputError(message: message)
    }
    
    func showPasswordError(message: String) {
        passwordWarningLabel.isHidden = false
        self.showInputError(message: message)
    }
    
    func showInputError(message: String? = nil) {
        self.showLoading(loading: false)
        
        guard let message = message else {
            usernameWarningLabel.isHidden = true
            passwordWarningLabel.isHidden = true
            loginContainerView.layer.borderColor = UIColor.clear.cgColor
            loginContainerView.layer.borderWidth = 0.0
            warningLabel.text = ""
            return
        }
        
        loginContainerView.layer.borderColor = UIColor.red.cgColor
        loginContainerView.layer.borderWidth = 1.0
        warningLabel.text = message
    }
    
    func showLoading(loading: Bool) {
        if loading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func login(withUsername username: String, password: String) {
        SessionService.shared.login(username: username, password: password).then {_ in
            self.goToHomePage(animated: true)
            self.showLoading(loading: false)
        }.catch { error in
            print(error)
            self.showInputError(message: "Your user name or password is incorrect")
            self.showLoading(loading: false)
        }
    }
    
    func goToHomePage(animated: Bool) {
        let identifier = animated ? LoggedInSegueIdentifier : LoggedInNoAnimationSegueIdentifier
        self.performSegue(withIdentifier: identifier, sender: nil)
    }
    
    func touchUpInside() {
        self.performSegue(withIdentifier: "SignUpModalIdentifier", sender: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showInputError()
    }
}
