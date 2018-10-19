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
    static let kLogoutNotificationKey = "logout_notification_key"
    
    static let shared = SessionService()
    static let url = "connect"

    static var user: AppUser?
    static var passwordItems: [KeychainPasswordItem] = []
    
    override init() {}
    
    static func login(username: String, password: String) -> Promise<AppUser> {
        let uri = "\(SessionService.url)/token"
        let body = "client_id=com.revoji&client_secret=secret&grant_type=password&username=\(username)&password=\(password)".data(using: .utf8)!

        UserDefaults.standard.setValue(username, forKey: "username")
        
        return APIService.getToken(url: uri, body: body).then { token in
            return AppUserAPIService.getApiUser().then { user in
                SessionService.user = user //user defaults?
            }
        }
    }
    
    static func logout() {
        SessionService.user = nil
        APIService.accessToken = nil
        NotificationCenter.default.post(name: Notification.Name(rawValue: kLogoutNotificationKey),
                                        object: self,
                                        userInfo: nil)
    }
}
