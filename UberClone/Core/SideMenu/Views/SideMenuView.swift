//
//  SideMenuView.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/12.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        NavigationStack {
            VStack (spacing: 40){
                //header view
                
                VStack(alignment: .leading, spacing: 32) {
                    HStack {
                        Image("male-profile-photo")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 64, height: 64)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Buhle Radzilani")
                                .font(.system(size: 16, weight: .semibold))
                            
                            Text("test@gmail.com")
                                .font(.system(size: 14))
                                .accentColor(.black)
                                .opacity(0.77)
                        }
                    }
                    
                    
                    // become a driver
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Do more with your account")
                            .font(.footnote)
                        .fontWeight(.semibold)
                        
                        
                        HStack {
                            Image(systemName: "dollarsign.square")
                                .font(.title2)
                                .imageScale(.medium)
                            
                            Text("Make money driving")
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    
                    //this is the line dividing the side option menu
                    Rectangle()
                        .frame(width: 296, height: 0.75)
                        .opacity(0.7)
                        .foregroundColor(Color(.separator))
                        .shadow(color: .black.opacity(0.7), radius:  4)
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                
               
                //option list
                VStack {
                    ForEach(SideMenuOptionViewModel.allCases) { viewModel in
                        NavigationLink(value: viewModel) {
                            SideMenuOptionView(viewModel: viewModel)
                                .padding()
                        }
                    }
                }
                .navigationDestination(for: SideMenuOptionViewModel.self) { viewModel in
                    Text(viewModel.title)
                }
                
                Spacer()
              
            }
            .padding(.top)
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
