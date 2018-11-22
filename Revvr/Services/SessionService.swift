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

    // Store user info in userdefaults
    var user: AppUser? {
        get {
            if let data = UserDefaults.standard.value(forKey:kUserObjectKey) as? Data {
                return try? PropertyListDecoder().decode(AppUser.self, from: data)
            }
            return nil
        }
        set {
            if let newUser = newValue {
                UserDefaults.standard.set(try? PropertyListEncoder().encode(newUser), forKey:kUserObjectKey)
            } else {
                UserDefaults.standard.removeObject(forKey: kUserObjectKey)
            }
        }
    }
    
    override init() {}
    
    func login(username: String, password: String) -> Promise<AppUser> {
        let uri = "connect/token"
        let body = "client_id=\(kClientId)&client_secret=\(kClientSecret)&grant_type=\(kGrantType)&username=\(username)&password=\(password)".data(using: .utf8)!

        // This is confusing from a dev stand point.
        // Need to figure out a way to not need this.
        UserDefaults.standard.setValue(username, forKey: "username")
        
        return getToken(url: uri, body: body).then { token in
            return AppUserAPIService.shared.getApiUser().then { user in
                self.user = user
            }
        }
    }
    
    func logout() {
        user = nil
        accessToken = nil
        
        DispatchQueue.main.async {
            let nav = UIApplication.shared.delegate?.window??.rootViewController as! UINavigationController
            nav.popToRootViewController(animated: true)
        }
    }
    
    func isLoggedIn() -> Bool {
        return user != nil &&
            accessToken != nil &&
            UserDefaults.standard.value(forKey: KeyChainService.shared.kUserNameKey) != nil
    }
}
