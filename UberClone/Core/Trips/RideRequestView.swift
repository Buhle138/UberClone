//
//  RideRequestView.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/06.
//

import SwiftUI

struct RideRequestView: View {
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
            
            //Trip info view
            VStack {
                //header view
                HStack {
                    VStack {
                        Circle()
                            .fill(Color(.systemGray))
                            .frame(width: 8, height: 8)
                        
                        Rectangle()
                            .fill(Color(.systemGray3))
                            .frame(width: 1, height: 32)
                        
                        Rectangle()
                            .fill(.black)
                            .frame(width: 8, height: 8)
                    }
                    
                    VStack (alignment: .leading, spacing: 24) {
                        HStack {
                            Text("Current location")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Text("1:30 PM")
                                .font(.system(size: 15, weight: .semibold))
                        }
                        .padding(.bottom, 10)
                        
                        //Destination view
                        HStack {
                            Text("Starbucks Coffee")
                                .font(.system(size: 16, weight: .semibold))
                                
                            
                            Spacer()
                            
                            Text("1:45 PM")
                                .font(.system(size: 15, weight: .semibold))
                        }
                        
                    }
                    .padding(.leading, 8)
                }
                .padding()
                
                Divider()
                
                Text("SUGGESTED RIDES")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(0 ..< 3, id: \.self){_ in
                            VStack(alignment: .leading) {
                                Image("uber-x")
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                }
                
                
                //ride type selection view
                
                // payment option view
                
                //request ride button
            }
        }
    }
    
    struct RideRequestView_Previews: PreviewProvider {
        static var previews: some View {
            RideRequestView()
        }
    }
}
