//
//  AppUser.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-03.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class AppUser: ModelObject {
    static var User: AppUser?// The current user of the app
    
    var firstName: String
    var lastName: String
    var city: String?
    var administrativeArea: String?
    var country: String?
    var dob: Date
    var gender: String?
    var religion: String?
    var politics: String?
    var education: String?
    var profession: String?
    var interests: String?
    
    var handle: String
    var email: String
    var password: String

    var content: AppUserContent?
    var settings: AppUserSettings?
    
    override var data: Data? {
        get {
            var dict = [String: Any]()

            dict["firstName"] = firstName
            dict["lastName"] = lastName
            dict["dob"] = ModelObject.dateStringForDate(date: dob)
            dict["handle"] = handle
            dict["email"] = email
            dict["password"] = password
            
            dict["city"] = city
            dict["administrativeArea"] = administrativeArea
            dict["country"] = country
            dict["gender"] = gender
            dict["religion"] = religion
            dict["politics"] = politics
            dict["education"] = education
            dict["profession"] = profession
            dict["interests"] = interests

            return try? JSONSerialization.data(withJSONObject: dict, options:[])
        }
    }

    init(firstName: String,
         lastName: String,
         dob: Date,
         handle: String,
         email: String,
         password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.dob = dob
        self.handle = handle
        self.email = email
        self.password = password
        
        super.init()
    }
    
    required init?(json: [String: Any]) {
        guard let firstName = json["firstName"] as? String,
            let lastName = json["lastName"] as? String,
            let dob = json["dob"] as? String,
            let handle = json["handle"] as? String,
            let email = json["email"] as? String,
            let password = json["password"] as? String
        else {
            return nil
        }

        self.firstName = firstName
        self.lastName = lastName
        self.handle = handle
        self.email = email
        self.dob = ModelObject.dateFromDateString(dateString: dob)
        self.password = password
        
        super.init(json: json)
    }
}
