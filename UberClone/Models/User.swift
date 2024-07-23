//
//  User.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/12.
//

import Foundation
import Firebase

//Distinguishing between a user and driver account type


//BIG NOTE: SWIFT AUTOMATICALLY ASSIGNS  NUMBERS TO THESE CASES
//SO PASSENGER IS ZERO AND DRIVER IS 1 ONE
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
