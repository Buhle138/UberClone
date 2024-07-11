//
//  RegistrationView.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/09.
//

import SwiftUI

struct RegistrationView: View {
    @State private var fullname = ""
    
    @State private var email = ""
    
    @State private var password = ""
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .imageScale(.medium)
                        .padding()
                }
                
                Text("Create new account")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .frame(width: 250)
                
                Spacer()
                
              
                
                VStack(spacing: 56) {
                    CustomInputField(text: $fullname, title: "Full Name", placeholder: "Enter your name")
                    
                    CustomInputField(text: $fullname, title: "Full Name", placeholder: "Enter your name")
                    
                    CustomInputField(text: $fullname, title: "Full Name", placeholder: "Enter your name")
                }
                .padding(.leading)
                
                Button {
                    
                } label: {
                    HStack {
                        Text("SIGN UP")
                            .foregroundColor(.black)
                        
                        Image(systemName: "arrow.right")
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                .background(Color.white)
                .cornerRadius(10)

            }
            .foregroundColor(.white)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
