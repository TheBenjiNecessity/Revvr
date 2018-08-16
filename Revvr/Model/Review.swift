//
//  Review.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-03.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class Review: ModelObject {

    var appUserID: Int
    var reviewableID: Int
    var title: String?
    var created: Date
    var comment: String?
    var emojis: String
    
    init(ID: Int, appUserID: Int, reviewableID: Int, created: Date, emojis: String) {
        self.appUserID = appUserID
        self.reviewableID = reviewableID
        self.emojis = emojis
        self.created = created
        
        super.init()
    }
    
    required init?(json: [String: Any]) {
        return nil
    }
}
