//
//  AppUser.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-03.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//
import Foundation

struct AppUser: Codable {
    let id: Int?
    
    let firstName: String
    let lastName: String
    let handle: String
    let email: String
    let password: String
    
    let city: String?
    let administrativeArea: String?
    let country: String?
    let dob: Date?
    let gender: String?
    let religion: String?
    let politics: String?
    let education: String?
    let profession: String?
    let interests: String?
    
    let content: AppUserContent?
    let settings: AppUserSettings?
    
    init(firstName: String,
        lastName: String,
        handle: String,
        email: String,
        password: String,
        city: String? = nil,
        administrativeArea: String? = nil,
        country: String? = nil,
        dob: Date? = nil,
        gender: String? = nil,
        religion: String? = nil,
        politics: String? = nil,
        education: String? = nil,
        profession: String? = nil,
        interests: String? = nil,
        content: AppUserContent? = nil,
        settings: AppUserSettings? = nil) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.handle = handle
        self.email = email
        self.password = password
        
        self.id = -1
        self.city = city
        self.administrativeArea = administrativeArea
        self.country = country
        self.dob = dob
        self.gender = gender
        self.religion = religion
        self.politics = politics
        self.education = education
        self.profession = profession
        self.interests = interests
        
        self.content = content
        self.settings = settings
    }
}
