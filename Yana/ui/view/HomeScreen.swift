//
//  HomeScreen.swift
//  Yana
//
//  Created by serhat on 27.12.2023.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var userViewModel: UsersViewModel
    @State private var userName = "Default User"
//    @ObservedObject var vm = ChatMessageViewModel()
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
          
            ZStack{
                Color(red: 200/255, green: 162/255, blue: 200/255).opacity(0.5)
                    .ignoresSafeArea()
                VStack(spacing:screenHeight/30){
                    
                    
                    HStack(spacing:screenWidth/25){
                        Circle()
                            .foregroundColor(.clear)
                            .frame(width: screenWidth/5,height: screenWidth/5)
                            .background(
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            )
                        
                        Text(userName).font(.title2).bold()
                        Spacer()
                    }
                   
                    CustomHomePageItems(itemImageWidth: screenHeight/20, itemImageHeight: screenHeight/20, itemHeight: screenWidth/8, itemWidth: screenWidth*0.75, imageName: "dove", itemName: "15.Gün", itemColor: Color(red: 0/255, green: 119/255, blue: 190/255).opacity(0.30),cornerRadiusSize: 100.0,itemNameSize: 20.0,spacing: screenWidth/25)
                  
                   Spacer()
                    CustomHomePageItems(itemImageWidth: screenHeight/10, itemImageHeight: screenHeight/10, itemHeight: screenHeight/4, itemWidth: .infinity, imageName: "flag", itemName: "Başarı Hikayelerinden İlham Alın", itemColor: Color(red: 253/255, green: 237/255, blue: 150/255).opacity(0.90),cornerRadiusSize: 50.0,itemNameSize: screenWidth/20,spacing: screenWidth/25)
                    CustomHomePageItems(itemImageWidth: screenWidth/5, itemImageHeight: screenWidth/5, itemHeight: screenHeight/4, itemWidth: .infinity, imageName: "liste", itemName: "Kendine Göre Tetikleyiciler Listesi Hazırla", itemColor: Color(red: 174/255, green: 217/255, blue: 224/255).opacity(0.80), cornerRadiusSize: 50.0,itemNameSize: screenWidth/20,spacing: screenWidth/25)
                    Spacer()
                    
                }.frame(width: screenWidth*0.75,height: screenHeight*0.75).padding(.vertical,screenHeight/50)
           }
            .onAppear() {
                userName = userViewModel.userInformation.first?.userName ?? "Nil User"
//                vm.cleanCoreData()
            }
//            .onChange(of: userViewModel.userInformation) { newValue in
//                // userInformation değiştiğinde userName'i güncelle
//                userName = newValue.first?.userName ?? "NilUser"
//            }
        }
    }
}
//#Preview {
//    HomeScreen()
//}
