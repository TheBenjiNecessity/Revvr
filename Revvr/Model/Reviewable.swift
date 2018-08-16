//
//  Reviewable.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-03.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class Reviewable: ModelObject {
    var title: String
    var reviewableType: String
    var reviewableDescription: String?
    var titleImageUrl: String?
    
    override var data: Data? {
        get {
            var dict = [String: Any]()
            
            dict["title"] = title
            dict["type"] = reviewableType
            dict["description"] = reviewableDescription
            dict["titleImageUrl"] = titleImageUrl
            
            return try? JSONSerialization.data(withJSONObject: dict, options:[])
        }
    }
    
    required init?(json: [String: Any]) {
        guard let title = json["title"] as? String,
            let reviewableType = json["type"] as? String
        else {
            return nil
        }
        
        self.title = title
        self.reviewableType = reviewableType
        
        self.reviewableDescription = json["description"] as? String
        self.titleImageUrl = json["titleImageUrl"] as? String
        
        super.init(json: json)
    }
}
