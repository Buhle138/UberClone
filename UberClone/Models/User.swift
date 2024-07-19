//
//  User.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/12.
//

import Foundation


struct User: Codable {
    
    let fullname: String
    let email: String
    let uid: String
    var homeLocation: SavedLocation?
    var userLocation: SavedLocation?
    
}
