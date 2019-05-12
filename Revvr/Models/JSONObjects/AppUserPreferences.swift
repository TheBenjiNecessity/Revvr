//
//  AppUserPreferences.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-05-11.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import Foundation

struct AppUserPreferences: Codable {
    let ageRange: String?
    let politicalAffiliation: Float?
    let politicalOpinion: Float?
    let location: String?
    let religiosity: Float?
    let personality: Float?
}
