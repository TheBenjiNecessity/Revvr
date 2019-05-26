//
//  Settings.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-25.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import Foundation

enum SettingsType: String, Decodable {
    case boolean
    case text
    case segment
    case info
    case setting
    case button
    // description?
}

// Representing the entire table view of settings
struct Setting: Decodable {
    let title: String
    let groups: [Group]
    
    init (title: String, groups: [Group]) {
        self.title = title
        self.groups = groups
    }
}

// Representing a section in the table view
struct Group: Decodable {
    let title: String
    let items: [Item]
}

// Representing a row in a group (that could have nested settings)
struct Item: Decodable {
    let title: String
    let itemType: SettingsType
    let setting: Setting?
    let value: String?
    let identifier: String?
}
