//
//  UpdatePasswordViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-01-01.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: UIViewController {
    
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBAction func donePress(_ sender: Any) {
        guard let oldPassword = oldPasswordTextField?.text,
            let newPassword = newPasswordTextField?.text,
            let confirmPassword = confirmPasswordTextField?.text,
            newPassword == confirmPassword
        else { return } //TODO: show error
        
        // TODO: Show loading
        AppUserAPIService.shared.updatePassword(newPassword: newPassword, oldPassword: oldPassword).then { _ in
            self.navigationController?.popViewController(animated: true)
        }.catch { error in
            
        }
    }
}
