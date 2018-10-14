//
//  AppUser.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-03.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//
import Foundation

struct AppUser: Codable {
    let ID: Int?
    
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
}
