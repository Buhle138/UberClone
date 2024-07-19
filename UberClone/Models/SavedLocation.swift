//
//  SavedLocation.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/18.
//

import Firebase

struct SavedLocation: Codable {
    let title: String
    let address: String
    let coordinates: GeoPoint //Allows us to upload coordinates to our database firebase.
}
