//
//  CustomHomePageItems.swift
//  Yana
//
//  Created by serhat on 2.01.2024.
//

import SwiftUI

struct CustomHomePageItems: View {
    var itemImageWidth: Double
    var itemImageHeight:Double
    var itemHeight:Double
    var itemWidth:Double
    var imageName:String
    var itemName:String
    var itemColor:Color
    var cornerRadiusSize:CGFloat
    var itemNameSize:CGFloat
    var spacing:CGFloat
    var body: some View {
        
        HStack(spacing:spacing){
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: itemImageWidth,height: itemImageHeight)
                .background(
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                )
           
            Text(itemName).font(.system(size: itemNameSize)).bold()
            
        }.padding().frame(width: itemWidth,height: itemHeight).background(
            itemColor
                .cornerRadius(cornerRadiusSize)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadiusSize)
                        .stroke(Color.black, lineWidth: 2)
                )
                
                
        )
        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 2)
    }
}

//#Preview {
//    CustomHomePageItems()
//}
