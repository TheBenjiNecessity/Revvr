//
//  AppUser.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-03.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//
import Foundation

struct AppUser: Codable {
    let id: Int
    
    let firstName: String
    let lastName: String
    let handle: String
    let email: String
    
    let city: String?
    let administrativeArea: String?
    let country: String?
    let dateOfBirth: Date?
    let gender: String?
    let religion: String?
    let politics: String?
    let education: String?
    let profession: String?
    let interests: String?
    
    init() {
        self.init(id: -1, firstName: "", lastName: "", handle: "", email: "")
    }
    
    init(id: Int,
        firstName: String,
        lastName: String,
        handle: String,
        email: String,
        city: String? = nil,
        administrativeArea: String? = nil,
        country: String? = nil,
        dateOfBirth: Date? = nil,
        gender: String? = nil,
        religion: String? = nil,
        politics: String? = nil,
        education: String? = nil,
        profession: String? = nil,
        interests: String? = nil) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.handle = handle
        self.email = email
        
        self.id = id
        self.city = city
        self.administrativeArea = administrativeArea
        self.country = country
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.religion = religion
        self.politics = politics
        self.education = education
        self.profession = profession
        self.interests = interests
    }
}
