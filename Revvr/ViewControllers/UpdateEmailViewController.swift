//
//  UpdateEmailViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-01-01.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

class UpdateEmailViewController: UIViewController {
    var email = ""

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var newEmailTextField: UITextField!
    @IBOutlet weak var confirmEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailLabel?.text = email
    }
    
    @IBAction func donePress(_ sender: Any) {
        guard let newEmail = newEmailTextField?.text,
            let confirmEmail = confirmEmailTextField?.text,
            newEmail == confirmEmail
        else { return } //TODO: show error
        
        // TODO: Show loading
        AppUserAPIService.shared.updateEmail(email: newEmail).then { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }
}
