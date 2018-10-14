//
//  APIService.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-01.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

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
        let promise = Promise<Data>.pending()
        let uri = APIService.serviceUrl + url
        var request = URLRequest(url: URL(string: uri)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod
        
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
                promise.fulfill(data!)
            } else if error != nil {
                promise.reject(error!)
            }
        }
        task.resume()
        
        return promise
    }
    
    static func getModel<T: Codable>(data: Data, type: T.Type) -> Promise<T> {
        let promise = Promise<T>.pending()
        
        do {
            let model = try JSONDecoder().decode(type.self, from: data)
            promise.fulfill(model)
        } catch let error {
            promise.reject(error)
        }
        
        return promise
    }
    
    static func getModels<T: Codable>(data: Data, type: [T].Type) -> Promise<[T]> {
        let promise = Promise<[T]>.pending()
        
        do {
            let model = try JSONDecoder().decode(type.self, from: data)
            promise.fulfill(model)
        } catch let error {
            promise.reject(error)
        }
        
        return promise
    }
    
    static func getData<T: Codable>(model: T) -> Data? {
        do {
            return try JSONEncoder().encode(model)
        } catch {
            //logging?
            return nil
        }
    }
}
