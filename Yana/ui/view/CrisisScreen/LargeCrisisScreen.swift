//
//  LargeCrisisScreen.swift
//  Yana
//
//  Created by serhat on 29.12.2023.
//

import SwiftUI

struct LargeCrisisScreen: View {
    let word = "Koşullar sizi yenmez; pes ettiğinizde kendinizi yenersiniz.-Jonathan Lockwood Huie "
    var body: some View {
      
            
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height
                ZStack {
                    Color(red: 230/255, green: 230/255, blue: 255/255)
                        .ignoresSafeArea()
                    VStack(spacing:screenWidth/10){
                     
                        HStack{
                         
                                Rectangle()
                                  .foregroundColor(.clear)
                                  .frame(width: screenWidth/10,height: screenWidth/10)
                                  .background(
                                          Image("freedom")
                                                    .resizable()
                                                                   .aspectRatio(contentMode: .fill)
                                                           )
                               Spacer()
                                Text(word).font(.custom("Irish grover", size: screenWidth/30))
                           
                            Rectangle()
                              .foregroundColor(.clear)
                              .frame(width: screenWidth/10,height: screenWidth/10)
                              .background(
                                      Image("freedom")
                                                .resizable()
                                                               .aspectRatio(contentMode: .fill)
                                                       )
                        }.padding(.top,screenHeight/10)
                       
                        VStack(spacing:screenWidth/10){
                            HStack{
                              CustomItemCrisis(imageName: "piano", itemWidth: screenHeight/10, itemHeight: screenHeight/5)
                                Spacer()
                                CustomItemCrisis(imageName: "gameMenu", itemWidth: screenHeight/10, itemHeight: screenHeight/5)
                            }
                            HStack{
                                CustomItemCrisis(imageName: "intelligence", itemWidth: screenHeight/10, itemHeight: screenHeight/5)
                                Spacer()
                                CustomItemCrisis(imageName: "yoga", itemWidth: screenHeight/10, itemHeight: screenHeight/5)
                            }
                        }
                        Spacer()
                        
                       
                        
                    }.padding(.horizontal,screenWidth/5).padding(.top,screenWidth/30)
                }
            }
        }
    }

#Preview {
    LargeCrisisScreen()
}
