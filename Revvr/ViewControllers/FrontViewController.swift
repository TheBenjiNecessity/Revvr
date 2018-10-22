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
    
    override func viewWillAppear(_ animated: Bool) {
        if SessionService.sharedSessionService.isLoggedIn() {
            self.performSegue(withIdentifier: "LoggedInNoAnimationSegueIdentifier", sender: nil)
        }
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
        case .Signup:
            guard let firstName = signupFirstNameField.text,
                let lastName = signupLastNameField.text,
                let email = signupEmailField.text,
                let username = signupUserNameField.text,
                let password = signupPasswordField.text
                else {
                // TODO check for empty fields
                print("Not all details entered")
                return
            }
            
            let json = """
            {
                "firstName": "\(firstName)",
                "lastName": "\(lastName)",
                "handle": "\(username)",
                "email": "\(email)",
                "password": "\(password)"
            }
            """.data(using: .utf8)!
            
            if let user = try? JSONDecoder().decode(AppUser.self, from: json) {
                AppUserAPIService.sharedAppUserService.create(user: user).then { userResp in
                    self.login(withUsername: username, password: password)
                }.catch { error in
                    print(error)
                }
            }
            
            break
        case .Login:
            guard let username = loginUsernameField.text,
                let password = loginPasswordField.text else {
                print("invalid credentials")
                return
            }
            
            login(withUsername: username, password: password)
            
            break
        default: break
        }
    }

    func initStyles() {
        loginContainerView.layer.cornerRadius = 5.0
        signupContainerView.layer.cornerRadius = 5.0
    }
    
    func login(withUsername username: String, password: String) {
        SessionService.sharedSessionService.login(username: username,
                                                  password: password).then {_ in
            self.performSegue(withIdentifier: "LoggedInSegueIdentifier", sender: nil)
        }.catch { error in
            print(error)
        }
    }
}
