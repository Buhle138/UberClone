//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/04.
//

import SwiftUI

@main
struct UberCloneApp: App {
    
    
    //WE ARE USING THIS VARIABLE AND INJECTING IT INTO THE ENVIRONMENT OBJECT SO THAT WE CAN INITIATE/CALL IT'S CONSTRUCTOR ONCE AND USE IT THROUGHOUT THE ENTIRE APPLICATION AS AN ENVIRONMENT OBJECT WRAPPER.
    //ONCE WE CALL THIS LocationSearchViewModel AS AN ENVIRONMENT OBJECT THERE IS NO NEED FOR US TO CALL IT'S CONSTRUCTOR ANY MORE THROUGHOUT THE ENTIRE APPLICATION.
    
    //IF YOU WHERE
    @StateObject var locationViewModel = LocationSearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
