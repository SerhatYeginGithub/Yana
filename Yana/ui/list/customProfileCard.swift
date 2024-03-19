//
//  customProfileCard.swift
//  Yana
//
//  Created by serhat on 29.01.2024.
//

import SwiftUI

struct customProfileCard: View {
//    @State var userName :String
    
    var body: some View {
        GeometryReader {geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
     
            Rectangle()
                .fill(.clear)
                .frame(width: screenWidth,height: screenHeight/6)
                .overlay(
                    HStack(spacing:screenWidth/25){
                                        Circle()
                                            .foregroundColor(.clear)
                                            .frame(width: screenWidth/5,height: screenWidth/5)
                                            .background(
                                                Image(systemName: "person.crop.circle.fill")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                            )
                    
                                        Text("userName").font(.custom("Irish grover", size: screenHeight/20)).bold()
                                        Spacer()
                                    }
                )
                
                
            
            
//            HStack{
//                HStack(spacing:screenWidth/25){
//                    Circle()
//                        .foregroundColor(.clear)
//                        .frame(width: screenWidth/5,height: screenWidth/5)
//                        .background(
//                            Image(systemName: "person.crop.circle.fill")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                        )
//                    
//                    Text(userName).font(.custom("Irish grover", size: screenHeight/20)).bold()
//                    Spacer()
//                }
//            }.frame(width: .infinity,height: screenHeight).border(Color.black)
        }
    }
}

#Preview {
    customProfileCard()
}
