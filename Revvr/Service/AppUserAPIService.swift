//
//  AppUserAPIService.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-08-01.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class AppUserAPIService: APIService {
    let url = "appuser/"
    
    func get(id: Int) {
        super.get(uri: "\(url)\(id)", postString: "")
    }
}
