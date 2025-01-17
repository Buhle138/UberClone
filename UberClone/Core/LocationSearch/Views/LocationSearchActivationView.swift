//
//  LocationSearchActivationView.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/05.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.black)
                .frame(width: 8, height: 8)
                .padding(.horizontal)
            
            Text("Where to?")
                .foregroundColor(Color(.darkGray))
            
            Spacer()
        }
        
        //Adding a background and a shadow to that background
        
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(Rectangle().fill(Color.white).shadow(color: .black, radius: 6))
        
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
