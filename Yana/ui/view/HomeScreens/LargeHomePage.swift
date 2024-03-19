////
////  LargeHomePage.swift
////  Yana
////
////  Created by serhat on 2.01.2024.
////
//
//import SwiftUI
//
//struct LargeHomePage: View {
//    var body: some View {
//        GeometryReader { geometry in
//            let screenWidth = geometry.size.width
//            let screenHeight = geometry.size.height
//            ZStack{
//                Color(red: 200/255, green: 162/255, blue: 200/255).opacity(0.5)
//                    .ignoresSafeArea()
//                VStack(spacing:screenHeight/30){
//                    
//                    
//                    HStack(spacing:screenWidth/25){
//                        Circle()
//                            .foregroundColor(.clear)
//                            .frame(width: screenWidth/5,height: screenWidth/5)
//                            .background(
//                                Image(systemName: "person.crop.circle.fill")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                            )
//                        
//                        Text("Crazy Girl43").font(.custom("Irish grover", size: screenWidth/20)).bold()
//                        Spacer()
//                    }
//                   
//                    CustomHomePageItems(itemImageWidth: screenWidth/8, itemImageHeight: screenWidth/10, itemHeight: screenWidth/8, itemWidth: screenWidth*0.75, imageName: "dove", itemName: "15.Gün", itemColor: Color(red: 0/255, green: 119/255, blue: 190/255).opacity(0.30),cornerRadiusSize: 100.0,itemNameSize: screenWidth/20)
//                  
//                   Spacer()
//                    CustomHomePageItems(itemImageWidth:  screenWidth/8, itemImageHeight:  screenWidth/8, itemHeight: screenWidth/4, itemWidth: .infinity, imageName: "flag", itemName: "Başarı Hikayelerinden İlham Alın", itemColor: Color(red: 253/255, green: 237/255, blue: 150/255).opacity(0.90),cornerRadiusSize: 50.0,itemNameSize: screenWidth/20)
//                    CustomHomePageItems(itemImageWidth: screenWidth/8, itemImageHeight:  screenWidth/8, itemHeight: screenWidth/4, itemWidth: .infinity, imageName: "liste", itemName: "Kendine Göre Yapılacaklar Listesi Hazırla", itemColor: Color(red: 174/255, green: 217/255, blue: 224/255).opacity(0.80), cornerRadiusSize: 50.0,itemNameSize: screenWidth/25)
//                    Spacer()
//                    
//                }.padding(screenWidth/10)
//            }
//        }
//    }
//}
//
//#Preview {
//    LargeHomePage()
//}
