//
//  SmallCrisisScreen.swift
//  Yana
//
//  Created by serhat on 29.12.2023.
//

import SwiftUI

struct SmallCrisisScreen: View {
    let word = "Koşullar sizi yenmez; pes ettiğinizde kendinizi yenersiniz.-Jonathan Lockwood Huie "
    var body: some View {
        
            
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height
                ZStack {
                    Color(red: 200/255, green: 162/255, blue: 200/255).opacity(0.5)
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
                                Text(word).font(.custom("Irish grover", size: screenWidth/20))
                           
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
                        
                       
                        
                    }.padding(.horizontal,screenWidth/10).padding(.top,screenWidth/25)
                }
            }
        }
    }




#Preview {
    SmallCrisisScreen()
}





