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
                    //User info header
                    HStack {
                        Image("male-profile-photo")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 64, height: 64)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Buhle")
                                .font(.system(size: 16, weight: .semibold))
                            
                            Text("buhle@gmail.com")
                                .font(.system(size: 14))
                                .accentColor(Color.theme.primaryTextColor)
                                .opacity(0.77)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                        
                    }
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
