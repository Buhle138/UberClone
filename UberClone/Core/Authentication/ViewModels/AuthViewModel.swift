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
    
    func signIn(withEmail email: String, password: String){
        
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if let error = error {
                print("Debug failed to sign in with error \(error.localizedDescription)")
                return
            }
            
            print("Debug Sign user in successfully")
            print("Debug: user id \(result?.user.uid)")
        }
        
    }
    
    func registerUser(withEmail email: String, password: String, fullname: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Debug failed to sign up with error \(error.localizedDescription)")
                return
            }
          
        }
    }
    
    func signout() {
       
        do {
            try Auth.auth().signOut()
            print("DEBUG did sign out ")
        }catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
}
