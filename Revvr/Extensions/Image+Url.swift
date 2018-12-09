//
//  Image+Url.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-16.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

extension UIImage {
    static func image(from urlString: String) -> UIImage? {
        guard let url = URL(string: urlString),
              let imageData = try? Data(contentsOf: url)
        else {
            return nil
        }
        
        return UIImage(data:imageData)
    }
}
