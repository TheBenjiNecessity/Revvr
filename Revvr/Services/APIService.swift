//
//  APIService.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-01.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import Promises

class APIService: NSObject {//TODO this should be a singleton
    //TODO: add authentication header
    static private let errorDomain = "com.revvr.Revvr"
    static private let serviceUrl: String = "http://localhost:5001/"//TODO
    static private let kUserNameKey = "username"
    
    struct KeychainConfiguration {
        static let serviceName = "Revvr"
        static let accessGroup: String? = nil
    }
    
    static var accessToken: String? {
        get {
            var token: String? = nil;
            if let username = UserDefaults.standard.string(forKey: kUserNameKey) {
                do {
                    let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                            account: username,
                                                            accessGroup: KeychainConfiguration.accessGroup)
                    
                    token = try passwordItem.readPassword()
                } catch {}
            }
            return token
        }
        set {
            if let username = UserDefaults.standard.string(forKey: kUserNameKey) {
                do {
                    if let token = newValue {
                        let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                                account: username,
                                                                accessGroup: KeychainConfiguration.accessGroup)
                        
                        try passwordItem.savePassword(token)
                    } else {
                        let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                                account: username,
                                                                accessGroup: KeychainConfiguration.accessGroup)
                        
                        try passwordItem.deleteItem()
                        UserDefaults.standard.removeObject(forKey: kUserNameKey)
                    }
                } catch let error {
                    fatalError("Error updating keychain - \(error)")
                }
            }
        }
    }

    static func get<T: Codable>(url: String, type: T.Type) -> Promise<T> {
        return request(url: url, httpMethod: "GET", body: nil, type: type.self)
    }
   
    static func post<T: Codable>(url: String, body: Data, type: T.Type) -> Promise<T> {
        return request(url: url, httpMethod: "POST", body: body, type: type.self)
    }
    
    static func delete<T: Codable>(url: String, type: T.Type) -> Promise<T> {
        return request(url: url, httpMethod: "DELETE", body: nil, type: type.self)
    }
    
    static func getToken(url: String, body: Data) -> Promise<Token> {
        return request(url: url,
                       httpMethod: "POST",
                       body: body,
                       type: Token.self,
                       contentType: "application/x-www-form-urlencoded").then { token in
            accessToken = token.access_token
        }.catch { error in
            accessToken = nil
        }
    }
    
    //TODO if this ever returns 401 then log the user out
    static private func request<T: Codable>(url: String,
                                            httpMethod: String,
                                            body: Data?,
                                            type: T.Type,
                                            contentType: String = "application/json") -> Promise<T> {
        let promise = Promise<T>.pending()
        let uri = APIService.serviceUrl + url
        var request = URLRequest(url: URL(string: uri)!)
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod
        
        if let accessToken = accessToken {
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                let error = NSError(domain: NSURLErrorDomain,
                                    code: httpStatus.statusCode,
                                    userInfo: nil)
                promise.reject(error)
            } else if data != nil && error == nil {
                do {
                    let model = try JSONDecoder().decode(type.self, from: data!)
                    promise.fulfill(model)
                } catch let jsonError {
                    promise.reject(jsonError)
                }
            } else if error != nil {
                promise.reject(error!)
            }
        }
        task.resume()
        
        return promise
    }
    
    //TODO: need to figure out how to merge this into 'request'
    static func getData<T: Codable>(model: T) -> Data? {
        do {
            return try JSONEncoder().encode(model)
        } catch {
            //logging?
            return nil
        }
    }
}
