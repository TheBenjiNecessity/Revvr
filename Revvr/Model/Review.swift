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
    var created: Date?
    var comment: String?
    var emojis: String
    
    override var data: Data? {
        get {
            var dict = [String: Any]()
            
            dict["appUserID"] = appUserID
            dict["reviewableID"] = reviewableID
            dict["title"] = title
            dict["comment"] = comment
            dict["emojis"] = emojis
            dict["created"] = ModelObject.dateStringForDate(date: created)
            
            return try? JSONSerialization.data(withJSONObject: dict, options:[])
        }
    }
    
    required init?(json: [String: Any]) {
        guard let appUserID = json["appUserID"] as? Int,
            let reviewableID = json["reviewableID"] as? Int,
            let emojis = json["emojis"] as? String
        else {
            return nil
        }
        
        self.appUserID = appUserID
        self.reviewableID = reviewableID
        self.emojis = emojis
        self.created = ModelObject.dateFromDateString(dateString: json["created"] as? String)
        
        self.title = json["title"] as? String
        self.comment = json["comment"] as? String
        
        super.init(json: json)
    }
}
