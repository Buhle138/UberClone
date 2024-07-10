//
//  LoginView.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/09.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack{
            Color(.black)
                .ignoresSafeArea()
            
            VStack {
                //Image and title
                
                VStack(spacing: 16) {
                    //Image
                    Image("uber_app_icon")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                       
                        .frame(width: 200, height: 200)
                    
                    //Title
                    Text("Uber")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    //input fields
                    VStack(spacing: 32) {
                        
                        //Input field 1
                        VStack(alignment: .leading, spacing: 12){
                            //title
                            Text("Email Address")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.footnote)
                            //text field
                            TextField("Email", text: $email)
                                .foregroundColor(.white)
                            //divider
                            Rectangle()
                                .foregroundColor(Color(.init(white: 1, alpha: 0.3)))
                                .frame(width: UIScreen.main.bounds.width - 32, height: 0.7)
                        }
                        //input field 2
                        VStack(alignment: .leading, spacing: 12){
                            //title
                            Text("Password")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.footnote)
                            //text field
                            TextField("Enter your password", text: $password)
                                .foregroundColor(.white)
                            //divider
                            Rectangle()
                                .foregroundColor(Color(.init(white: 1, alpha: 0.3)))
                                .frame(width: UIScreen.main.bounds.width - 32, height: 0.7)
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    Button {
                        
                    } label: {
                        Text("Forgot Password?")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.top)
                            .padding(.trailing, 28)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)

                    //social sign in view
                    VStack {
                        //Dividers + text
                        
                        HStack (spacing: 24){
                            Rectangle()
                                .frame(width: 76, height: 1)
                                .foregroundColor(.white)
                            
                            Text("Sign in with social")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                        
                        //sign up button
                        HStack(spacing: 24){
                            Image("facebook-sign-in-icon")
                                .resizable()
                                .frame(width: 44, height: 44)
                            
                            Image("google-sign-in-icon")
                                .resizable()
                                .frame(width: 44, height: 44)
                            
                        }
                    }
                    .padding(.vertical)
                    //sign in button
                    
                    //sign up button
                }
                
               
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
