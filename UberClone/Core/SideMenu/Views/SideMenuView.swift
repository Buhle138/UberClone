//
//  SideMenuView.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/12.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack {
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
                
                //option list
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
            
            Spacer()
        }
        .padding(.top)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
