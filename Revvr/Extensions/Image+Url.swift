//
//  Image+Url.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-16.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

extension UIImage {
    static func imageFrom(urlString: String?) -> UIImage? {
        if let urlString = urlString, let url = URL(string: urlString) {
            do {
                return UIImage(data: try Data(contentsOf: url))
            } catch {}
        }
        
        return nil
    }
}
