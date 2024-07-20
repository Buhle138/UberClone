//
//  User.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/12.
//

import Firebase


//Distinguishing between a user and driver account type

enum AccountType: Int, Codable {
    case passenger
    case driver
}

struct User: Codable {
    
    let fullname: String
    let email: String
    let uid: String
    var coordinates: GeoPoint
    var accountType: AccountType //We are making this a variable because this account type can change.
    var homeLocation: SavedLocation?
    var workLocation: SavedLocation?
    
}
