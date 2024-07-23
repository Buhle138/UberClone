//
//  AuthViewModel.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/11.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift //so that we can encode the user

class AuthViewModel: ObservableObject {
    
    //this session is going to store information about the currently logged in user.
    //if there is nothing in this userSession that means no user is currently logged in .
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func signIn(withEmail email: String, password: String){
        
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if let error = error {
                print("Debug failed to sign in with error \(error.localizedDescription)")
                return
            }
            self.userSession = result?.user
            
    /*Fetching the user once we have a successful signup so that we get the actual details of the current
          user that signed up  */
            self.fetchUser()
        }
    }
    
    func registerUser(withEmail email: String, password: String, fullname: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Debug failed to sign up with error \(error.localizedDescription)")
                return
            }
            //letting the userSession know that we have a user when we are registered!.
            
            guard let firebaseUser = result?.user else {return}
            
            self.userSession = firebaseUser
            
            let user = User(
                fullname: fullname,
                email: email,
                uid: firebaseUser.uid,
                coordinates: GeoPoint(latitude: -25, longitude: 28),
                accountType: .driver
            )
            
            
            /*Fetching the user once we have a successful signup so that we get the actual details of the current
                  user that signed up  */
            self.currentUser = user
            
            //sending this user Object into a format which firestore can read
            guard let encodedUser = try? Firestore.Encoder().encode(user) else {return}
            
            Firestore.firestore().collection("users").document(firebaseUser.uid).setData(encodedUser)
           
        }
    }
    
    func signout() {
       
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            print("DEBUG did sign out ")
        }catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser () {
        
        //grabbing the currently logged in users id
        guard let uid = self.userSession?.uid else {return}
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Debug failed to sign up with error \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else {return}
            
            //Here we are fetching this data from firebase in the format of the User struct model which we created under the models folder.
           guard  let user = try? snapshot.data(as: User.self) else {return}
            
            self.currentUser = user
            
            print("DEBUG: current user  is \(user)")
            
        }
    }
}
