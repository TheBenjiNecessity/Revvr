//
//  SessionService.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-17.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import Foundation
import Promises

class SessionService: APIService {
    static let shared = SessionService()
    
    let kClientId = "com.revoji"
    let kClientSecret = "secret"//TODO
    let kGrantType = "password"
    let kUserObjectKey = "user"
    
    override init() {}
    
    func login(username: String, password: String) -> Promise<AppUser> {
        let uri = "connect/token"
        let body = "client_id=\(kClientId)&client_secret=\(kClientSecret)&grant_type=\(kGrantType)&username=\(username)&password=\(password)".data(using: .utf8)!

        // This is confusing from a dev stand point.
        // Need to figure out a way to not need this.
        UserDefaults.standard.setValue(username, forKey: "username")
        
        return getToken(url: uri, body: body).then { token in
            return AppUserAPIService.shared.getApiUser().then { user in
                AppUserAPIService.shared.currentUser = user
            }
        }
    }
    
    func logout() {
        accessToken = nil
        
        DispatchQueue.main.async {
            let nav = UIApplication.shared.delegate?.window??.rootViewController as! UINavigationController
            nav.popToRootViewController(animated: true)
        }
    }
    
    func doLogout() {
        let alert = UIAlertController(title: "Logout?", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Log out", style: .destructive, handler: { action in
            self.logout()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        if let window = UIApplication.shared.delegate?.window {
            window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func forcedLogout() {
        let alert = UIAlertController(title: nil, message: "Your session has ended.\nPlease log in again.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.logout()
        })
        
        alert.addAction(okAction)
        
        if let window = UIApplication.shared.delegate?.window {
            window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func isLoggedIn() -> Bool {
        return accessToken != nil &&
            UserDefaults.standard.value(forKey: KeyChainService.shared.kUserNameKey) != nil
    }
}
