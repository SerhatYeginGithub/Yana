//
//  CustomBubbleView.swift
//  Yana
//
//  Created by serhat on 18.02.2024.
//

import SwiftUI

struct CustomBubbleView: View {
    let color = Color(red: 209/255, green: 196/255, blue: 244/255)
    var body: some View {
        
        GeometryReader{geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            HStack {
                Spacer()
                Image("drug")
                                  .resizable() // Resizable özelliği ekleyin
                                  .scaledToFit() // Scaled to fit özelliği ekleyin
                                  .frame(width: screenWidth/4, height: screenHeight/4) // Boyutları ayarlayın
                                
                Spacer()
                VStack(alignment: .leading){
                    Spacer()
                    Text("Oda adı : Çilekeşler").font(.title3).fontWeight(.bold)
                    Text("Katılımcı Sayısı : 2/4")
                    Text("Katıl").foregroundColor(.white).padding().frame(width: screenWidth/3).background(.green).cornerRadius(20)
                    
                    
                }.padding()
                Spacer()
                
            }.frame(width: screenWidth,height: screenHeight/6).background(color).border(.black,width: 2).cornerRadius(10)
            
        }.padding()
    }
}

#Preview {
    CustomBubbleView()
}
