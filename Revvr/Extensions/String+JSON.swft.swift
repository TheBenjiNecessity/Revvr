//
//  String+JSON.swft.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-05-12.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import Foundation

extension String {
    func dictionary() -> [String: String] {
        var values: [String: String] = [:]
        var cleanString = self.replacingOccurrences(of: "[{}]", with: "", options: .regularExpression, range: nil)
        cleanString = cleanString.replacingOccurrences(of: "\"", with: "", options: .regularExpression, range: nil)
        
        for entry in cleanString.components(separatedBy: ",") {
            let item = entry.components(separatedBy: ":")
            let key = item[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let value = item[1].trimmingCharacters(in: .whitespacesAndNewlines)
            values[key] = value
        }

        return values
    }
}
