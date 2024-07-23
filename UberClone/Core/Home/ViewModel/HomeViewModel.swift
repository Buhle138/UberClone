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
    
    @Published var drivers = [User]()
    
    init() {
        fetchDrivers()
    }
    
    func fetchDrivers() {
        Firestore.firestore().collection("users")
            .whereField("accountType", isEqualTo: AccountType.driver.rawValue)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                
                //if each user inside of an array is optional then we use compactMap compactMap handles the compact map.
                //line of code below converts the documents (from firebase) into of type User
                let drivers = documents.compactMap({ try? $0.data(as: User.self)})
                self.drivers = drivers
                
             
                
            }
    }
    
}
