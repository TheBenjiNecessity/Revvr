//
//  APIService.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-01.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import Promises

class APIService: NSObject {
    private let errorDomain = "com.revvr.Revvr"
    private let serviceUrl: String = "http://localhost:5001/"//TODO

    var accessToken: String? {
        get {
            return KeyChainService.shared.getUserToken()
        }
        set {
            if let token = newValue {
                KeyChainService.shared.setUserToken(token: token)
            } else {
                KeyChainService.shared.removeUserToken()
            }
        }
    }
    
    override init() {}

    func get<T: Codable>(url: String, type: T.Type) -> Promise<T> {
        return request(url: url, httpMethod: "GET", body: nil, type: type.self)
    }
   
    func post<T: Codable>(url: String, body: T, type: T.Type) -> Promise<T> {
        return request(url: url, httpMethod: "POST", body: body, type: type.self)
    }
    
    func delete<T: Codable>(url: String, type: T.Type) -> Promise<T> {
        return request(url: url, httpMethod: "DELETE", body: nil, type: type.self)
    }
    
    func getToken(url: String, body: Data) -> Promise<Token> {
        let promise = Promise<Token>.pending()
        let uri = serviceUrl + url
        var request = URLRequest(url: URL(string: uri)!)
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                let error = NSError(domain: NSURLErrorDomain,
                                    code: httpStatus.statusCode,
                                    userInfo: nil)
                promise.reject(error)
            } else if data != nil && error == nil {
                do {
                    let token = try JSONDecoder().decode(Token.self, from: data!)
                    self.accessToken = token.access_token
                    promise.fulfill(token)
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
    
    //TODO if this ever returns 401 then log the user out
    private func request<T: Codable>(url: String,
                                            httpMethod: String,
                                            body: T?,
                                            type: T.Type,
                                            contentType: String = "application/json") -> Promise<T> {
        let promise = Promise<T>.pending()
        var uri = serviceUrl + url
        uri = uri.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        let urlForRequest = URL(string: uri)
        var request = URLRequest(url: urlForRequest!)
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod
        
        if let accessToken = accessToken {
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                let error = NSError(domain: NSURLErrorDomain,
                                    code: httpStatus.statusCode,
                                    userInfo: nil)
                promise.reject(error)
                if httpStatus.statusCode == 401 {
                    SessionService.shared.logout()
                }
            } else if data != nil && error == nil {
                do {
                    let formatter = DateFormatter()
                    let decoder = JSONDecoder()
                    
                    formatter.dateFormat = Date.format
                    decoder.dateDecodingStrategy = .formatted(formatter)
                    
                    let model = try decoder.decode(type.self, from: data!)
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
}
