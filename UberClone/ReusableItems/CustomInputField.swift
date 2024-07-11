//
//  CustomInputField.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/11.
//

import SwiftUI

struct CustomInputField: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField  = false
    
    var body: some View {
        //Input field 1
        VStack(alignment: .leading, spacing: 12){
            //title
            Text(title)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.footnote)
            
            
            if isSecureField {
               SecureField(placeholder, text: $text)
                    .foregroundColor(.white)
            }else {
                TextField(placeholder, text: $text)
                    .foregroundColor(.white)
            }
           
            //divider
            Rectangle()
                .foregroundColor(Color(.init(white: 1, alpha: 0.3)))
                .frame(width: UIScreen.main.bounds.width - 32, height: 0.7)
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(text: .constant(""), title: "Email", placeholder: "Buhle@gmail.com")
    }
}
