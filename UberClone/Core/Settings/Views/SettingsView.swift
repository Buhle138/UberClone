//
//  SettingsView.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/15.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            List {
                Section {
                  //
                    HeaderInfoView()
                }
                
                Section("Favorites") {
                    SavedLocationRowView(imageName: "house.circle.fill", title: "Home", subtitle: "Add Home")
                    
                    SavedLocationRowView(imageName: "archivebox.circle.fill", title: "Work", subtitle: "Add Work")
                }
                
                
                Section("Settings") {
                    SettingsRowView(imageName: "bell.circle.fill", title: "Notifications", tintColor: Color(.systemPurple))
                    
                    SettingsRowView(imageName: "creditcard.circle.fill", title: "Payment Methods", tintColor: Color(.systemBlue))
                }
                
                Section("Account") {
                    SettingsRowView(imageName: "dollarsign.circle.fill", title: "Make money driving", tintColor: Color(.systemGreen))
                    
                    SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color(.systemRed))
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
