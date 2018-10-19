//
//  Token.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-10-17.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

struct Token: Codable {
    let access_token: String
    let expires_in: Int
    let token_type: String
}
