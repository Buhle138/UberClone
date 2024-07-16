//
//  SavedLocationRowView.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/16.
//

import SwiftUI

struct SavedLocationRowView: View {
    
    let imageName: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: (imageName))
                .imageScale(.medium)
                .font(.title)
                .foregroundColor(Color(.systemBlue))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color.theme.primaryTextColor)
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }

    }
}

struct SavedLocationRowView_Previews: PreviewProvider {
    static var previews: some View {
        SavedLocationRowView(imageName: "house.circle.fill", title: "Home", subtitle: "Add Home")
    }
}
