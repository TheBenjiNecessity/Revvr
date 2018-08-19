//
//  APIService.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-01.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit
import Promises

class APIService: NSObject {
    static let errorDomain = "com.revvr.Revvr"
    static let serviceUrl: String = "http://localhost:5001/service-api/"//TODO

    static func get(url: String) -> Promise<Data> {
        return request(url: url, httpMethod: "GET", body: nil)
    }
   
    static func post(url: String, body: Data) -> Promise<Data> {
        return request(url: url, httpMethod: "POST", body: body)
    }
    
    static func delete(url: String) -> Promise<Data> {
        return request(url: url, httpMethod: "DELETE", body: nil)
    }
    
    static func request(url: String, httpMethod: String, body: Data?) -> Promise<Data> {
        let uri = APIService.serviceUrl + url
        var request = URLRequest(url: URL(string: uri)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod
        if let body = body {
            request.httpBody = body
        }
        
        let promise = Promise<Data>.pending()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                let error = NSError(domain: NSURLErrorDomain,
                                    code: httpStatus.statusCode,
                                    userInfo: nil)
                promise.reject(error)
            } else if data != nil && error == nil {
                promise.fulfill(data!)
            } else if error != nil {
                promise.reject(error!)
            }
        }
        task.resume()
        
        return promise
    }
    
    // Only use this function when you know that the backend will return an object
    static func getModelObjectPromise<T: ModelObject>(data: Data, type: T.Type) -> Promise<T> {
        let promise = Promise<T>.pending()
        let error = NSError(domain: APIService.errorDomain, code: 1, userInfo: nil)

        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
            if let obj = T.init(json: json!) {
                promise.fulfill(obj)
            } else {
                promise.reject(error)
            }
        } else {
            promise.reject(error)
        }
        
        return promise
    }
    
    // Only use this function when you know that the backend will return an array of objects
    static func getArrayPromise<T: ModelObject>(data: Data, type: T.Type) -> Promise<[T]> {
        let promise = Promise<[T]>.pending()
        
        func getTsFromData<T: ModelObject>(data: Data, type: T.Type) -> [T]? {
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let TJson = json as! [[String: Any]]
            return TJson.map { T.init(json: $0)! }
        }
        
        if let objs = getTsFromData(data: data, type: type) {
            promise.fulfill(objs)
        } else {
            let error = NSError(domain: APIService.errorDomain, code: 1, userInfo: nil)
            promise.reject(error)
        }
        
        return promise
    }
    
    static func getGenericPromise<T>(data: Data) -> Promise<T> {
        let promise = Promise<T>.pending();
        let error = NSError(domain: APIService.errorDomain, code: 1, userInfo: nil)
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? T {
            promise.fulfill(json!)
        } else {
            promise.reject(error)
        }
        
        return promise
    }
}
