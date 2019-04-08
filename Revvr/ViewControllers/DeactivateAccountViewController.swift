//
//  DeactivateAccountViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-04-07.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

class DeactivateAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func deactivateAccount(_ sender: Any) {
        let alert = UIAlertController(title: "Deactivate Account?", message: "Are you sure you want to deactivate your account?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Deactivate", style: .destructive, handler: { action in
            AppUserAPIService.shared.delete().then{_ in
                
            }.catch { error in
                
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
