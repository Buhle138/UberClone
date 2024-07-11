//
//  AuthViewModel.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/11.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject {
    
    //this session is going to store information about the currently logged in user.
    //if there is nothing in this userSession that means no user is currently logged in .
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        userSession = Auth.auth().currentUser
    }
    
}
