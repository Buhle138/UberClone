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
                    
                }
                
                Section("Settings") {
                    
                }
                
                Section("Account") {
                    
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
