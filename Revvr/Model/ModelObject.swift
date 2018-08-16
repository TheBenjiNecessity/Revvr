//
//  ModelObject.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-03.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class ModelObject: NSObject {
    static let dateFormatString = "yyyy-MM-dd'T'HH:mm:ss"
    
    var ID: Int?
    
    var data: Data? { get { return nil } }
    
    override init() {
        ID = nil
        super.init()
    }
    
    required init?(json: [String: Any]) {
        self.ID = json["id"] as? Int
        
        super.init()
    }
        
    // TODO: these functions should be stored somewhere else
    static func dateStringForDate(date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatString
        return formatter.string(from: date)
    }
    
    static func dateFromDateString(dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatString
        return dateFormatter.date(from: dateString)
    }
}
