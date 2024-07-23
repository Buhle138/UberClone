//
//  HomeViewModel.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class HomeViewModel: ObservableObject {
    
    
    init() {
        fetchDrivers()
    }
    
    func fetchDrivers() {
        Firestore.firestore().collection("users")
            .whereField("accountType", isEqualTo: AccountType.driver.rawValue)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                
                let users = documents.map({ try? $0.data(as: User.self)})
                
                
            }
    }
    
}
