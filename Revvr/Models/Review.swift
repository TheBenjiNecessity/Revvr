//
//  Review.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-03.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//
import Foundation

struct Review: Codable {
    let id: Int
    
    let appUserID: Int
    let reviewableID: Int?
    let title: String? //TODO: get rid of this
    let created: Date?
    let comment: String?
    let emojis: String
    
    let appUser: AppUser
    let reviewable: Reviewable
    
    init() {
        self.init(emojis: "", comment: "", appUser: AppUser(), reviewable: Reviewable())
    }
    
    init(emojis: String, comment: String?, appUser: AppUser, reviewable: Reviewable) {
        self.appUserID = appUser.id
        self.reviewableID = reviewable.id
        self.comment = comment == "" ? nil : comment
        self.emojis = emojis
        self.appUser = appUser
        self.reviewable = reviewable
        
        self.id = -1
        self.created = nil
        self.title = nil
    }
}
