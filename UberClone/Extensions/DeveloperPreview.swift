//
//  DeveloperPreview.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/23.
//



import SwiftUI
import Firebase

extension PreviewProvider{
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    
    static let shared = DeveloperPreview()
    
    let mocUser = User(
        fullname: "Buhle",
        email: "Buhle@gmail.com",
        uid: NSUUID().uuidString,
        coordinates: GeoPoint(latitude: -25, longitude: 28),
        accountType: .passenger,
        homeLocation: nil,
        workLocation: nil
    )
    
}
