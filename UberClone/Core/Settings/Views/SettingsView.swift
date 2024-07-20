//
//  SettingsView.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/15.
//

import SwiftUI

struct SettingsView: View {
    private let user: User
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                  //
                    HeaderInfoView(user: user)
                }
                
                Section("Favorites") {
                    
                    ForEach(SavedLocationViewModel.allCases) { viewModel in
                
                        NavigationLink {
                            SavedLocationSearchView( config: viewModel)
                        } label: {
                            SavedLocationRowView(viewModel: viewModel, user: user)
                        }

                        
                    }
                
                }
                
                
                Section("Settings") {
                    SettingsRowView(imageName: "bell.circle.fill", title: "Notifications", tintColor: Color(.systemPurple))
                    
                    SettingsRowView(imageName: "creditcard.circle.fill", title: "Payment Methods", tintColor: Color(.systemBlue))
                }
                
                Section("Account") {
                    SettingsRowView(imageName: "dollarsign.circle.fill", title: "Make money driving", tintColor: Color(.systemGreen))
                    
                    SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color(.systemRed))
                        .onTapGesture {
                            viewModel.signout()
                        }
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large) //Ensuring that the settings title remains ontop of the stack when we navigate from our side menu view
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(user: dev.mocUser)
        }
    }
}
