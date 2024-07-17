//
//  SavedLocationViewModel.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/17.
//

import Foundation


enum SavedLocationViewModel: Int, CaseIterable {
    case home
    case work
    
    var title: String {
        switch self {
        case     .home: return "Home"
        case     .work: return "Work"
        }
    }
    
    var imageName: String {
        switch self {
        case .home: return "house.circle.fill"
        case .work: return "archivebox.circle.fill"
        }
    }
}