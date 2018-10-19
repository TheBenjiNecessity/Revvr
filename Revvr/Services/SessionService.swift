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
    static let sharedSessionService = SessionService()
    
    let kLogoutNotificationKey = "logout_notification_key"

    var user: AppUser?
    var passwordItems: [KeychainPasswordItem] = []
    
    override init() {}
    
    func login(username: String, password: String) -> Promise<AppUser> {
        let uri = "connect/token"
        let body = "client_id=com.revoji&client_secret=secret&grant_type=password&username=\(username)&password=\(password)".data(using: .utf8)!

        UserDefaults.standard.setValue(username, forKey: "username")
        
        return getToken(url: uri, body: body).then { token in
            return AppUserAPIService.sharedAppUserService.getApiUser().then { user in
                self.user = user //user defaults?
            }
        }
    }
    
    func logout() {
        user = nil
        accessToken = nil
        NotificationCenter.default.post(name: Notification.Name(rawValue: kLogoutNotificationKey),
                                        object: self,
                                        userInfo: nil)
    }
}
