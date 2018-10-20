//
//  KeyChainService.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-19.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//
//  Serves as a wrapper for keychain access

import Foundation

class KeyChainService: NSObject {
    static let shared = KeyChainService()
    
    private let kUserNameKey = "username"
    
    struct KeychainConfiguration {
        static let serviceName = "Revvr"
        static let accessGroup: String? = nil
    }
    
    override init() {}
    
    func getUserToken() -> String? {
        var item: String? = nil;
        if let username = UserDefaults.standard.string(forKey: kUserNameKey) {
            do {
                let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                        account: username,
                                                        accessGroup: KeychainConfiguration.accessGroup)
                
                item = try passwordItem.readPassword()
            } catch {} // TODO: do something?
        }
        return item
    }
    
    func setUserToken(token: String) {
        if let username = UserDefaults.standard.string(forKey: kUserNameKey) {
            do {
                let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                        account: username,
                                                        accessGroup: KeychainConfiguration.accessGroup)
                
                try passwordItem.savePassword(token)
            } catch {} // TODO: do something?
        }
    }
    
    func removeUserToken() {
        if let username = UserDefaults.standard.string(forKey: kUserNameKey) {
            do {
                let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                        account: username,
                                                        accessGroup: KeychainConfiguration.accessGroup)
                
                try passwordItem.deleteItem()
                UserDefaults.standard.removeObject(forKey: kUserNameKey)
            } catch {} // TODO: do something?
        }
    }
}
