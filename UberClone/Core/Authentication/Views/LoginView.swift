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
                        CustomInputField(text: $email, title: "Email Address", placeholder: "name@example.com")
                         
                        //input field 2
                      CustomInputField(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                        
                        Button {
                            
                        } label: {
                            Text("Forgot Password?")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.top)
                                .padding(.top)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                   

                    //social sign in view
                    VStack {
                        //Dividers + text
                        
                        HStack (spacing: 24){
                            Rectangle()
                                .frame(width: 76, height: 1)
                                .foregroundColor(.white)
                                .opacity(0.5)
                            
                            Text("Sign in with social")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                            
                            Rectangle()
                                .frame(width: 76, height: 1)
                                .foregroundColor(.white)
                                .opacity(0.5)
                        }
                        
                        //sign up button
                        HStack(spacing: 24){
                            Button {
                                
                            } label: {
                                Image("facebook-sign-in-icon")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                            }

                            Button {
                                
                            } label: {
                                Image("google-sign-in-icon")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                            }

                            
                            
                        }
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    //sign in button
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Sign In")
                                .foregroundColor(.black)
                            
                            Image(systemName: "arrow.right")
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    Spacer()

                    //sign up button
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                                .font(.system(size: 14))
                            
                            Text("Sign Up")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(.white)
                    }

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
