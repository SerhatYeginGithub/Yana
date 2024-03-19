//
//  CustomButtonDesign.swift
//  Yana
//
//  Created by serhat on 28.12.2023.
//

import SwiftUI

struct CustomButtonDesign: View {
    var iconName : String
    var buttonName :String
    var screenHeight:Double
    var screenWidth:Double
    var redColor:Double
    var greenColor:Double
    var blueColor:Double
    var textColor :Color
    var body: some View {
       
            HStack{
                Image(systemName: iconName)
                Text(buttonName)
            }.font(.custom("Irish Grover", size: screenHeight/32))
        
            .foregroundColor(textColor)
            .padding()
            .frame(maxWidth: screenWidth/2)
           
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: redColor/255, green: greenColor/255, blue:blueColor/255))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
        )
        
    }
}

//#Preview {
//    CustomButtonDesign()
//}
