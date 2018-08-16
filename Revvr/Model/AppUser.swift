//
//  AppUser.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-03.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class AppUser: ModelObject {
    static var User: AppUser?// The current user of the app TODO: should this be a singleton?
    
    var firstName: String
    var lastName: String
    var handle: String
    var email: String
    var password: String
    
    var city: String?
    var administrativeArea: String?
    var country: String?
    var dob: Date?
    var gender: String?
    var religion: String?
    var politics: String?
    var education: String?
    var profession: String?
    var interests: String?

    var content: AppUserContent?
    var settings: AppUserSettings?
    
    override var data: Data? {
        get {
            var dict = [String: Any]()

            dict["firstName"] = firstName
            dict["lastName"] = lastName
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
            dict["dob"] = ModelObject.dateStringForDate(date: dob)

            return try? JSONSerialization.data(withJSONObject: dict, options:[])
        }
    }

    init(firstName: String,
         lastName: String,
         handle: String,
         email: String,
         password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.handle = handle
        self.email = email
        self.password = password
        
        super.init()
    }
    
    required init?(json: [String: Any]) {
        guard let firstName = json["firstName"] as? String,
            let lastName = json["lastName"] as? String,
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
        self.password = password
        
        self.dob = ModelObject.dateFromDateString(dateString: json["dob"] as? String)
        self.city = json["city"] as? String
        self.administrativeArea = json["administrativeArea"] as? String
        self.country = json["country"] as? String
        self.gender = json["gender"] as? String
        self.religion = json["religion"] as? String
        self.politics = json["politics"] as? String
        self.education = json["education"] as? String
        self.profession = json["profession"] as? String
        self.interests = json["interests"] as? String
        
        super.init(json: json)
    }
}
