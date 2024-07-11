//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/04.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
    return true
  }
}

@main
struct UberCloneApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    //WE ARE USING THIS VARIABLE AND INJECTING IT INTO THE ENVIRONMENT OBJECT SO THAT WE CAN INITIATE/CALL IT'S CONSTRUCTOR ONCE AND USE IT THROUGHOUT THE ENTIRE APPLICATION AS AN ENVIRONMENT OBJECT WRAPPER.
    //ONCE WE CALL THIS LocationSearchViewModel AS AN ENVIRONMENT OBJECT THERE IS NO NEED FOR US TO CALL IT'S CONSTRUCTOR ANY MORE THROUGHOUT THE ENTIRE APPLICATION.
    
    //IF YOU INSTANTIATED THIS VIEW MODEL INSIDE EACH DIFFERENT VIEW THEN YOU WHERE GOING TO HAVE A DIFFERENT VIEW MODEL FOR EACH VIEW. WE DON'T WANT THAT WE WANT TO SHARE THIS VIEW MODEL INFORMATION ACROSS ALL VIEWS USING THE SAME INFORMATION FOR ALL VIEWS. 
    @StateObject var locationViewModel = LocationSearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
