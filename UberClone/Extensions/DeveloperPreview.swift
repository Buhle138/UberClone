//
//  DeveloperPreview.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/20.
//
import SwiftUI
import Foundation

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
        accountType: .passenger,
        homeLocation: nil,
        workLocation: nil
    )
    
}
