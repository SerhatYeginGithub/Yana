//
//  LoadingView.swift
//  Yana
//
//  Created by serhat on 29.01.2024.
//

import SwiftUI

struct LoadingView: View {
    @ObservedObject var appViewModel :AppViewModel
    @ObservedObject var userViewModel : UsersViewModel
//    @ObservedObject var messageViewModel : ChatMessageViewModel
    @State private var isAnimating = false
    @State private var showTabbarScreen = false
    var body: some View {
        
        if showTabbarScreen{
            TabBarScreen(appViewModel: appViewModel, userViewModel:  userViewModel)
        }
        else{
            ZStack{
                Color(red: 200/255, green: 162/255, blue: 200/255).opacity(0.5)
                    .ignoresSafeArea()
                
                VStack {
                           Circle()
                               .trim(from: 0, to: 0.7)
                               .stroke(Color.purple, lineWidth: 5)
                               .frame(width: 50, height: 50)
                               .rotationEffect(.degrees(isAnimating ? 360 : 0))
                               .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                           
                           Text("Yükleniyor...")
                               .font(.headline)
                               .padding(.top, 16)
                       }
            }
          
                   .onAppear {
                       appViewModel.tabbarItems = .house
                       isAnimating = true
                       userViewModel.fetchData()
                   }
                   .onChange(of: userViewModel.userInformation) { newValue in
                      showTabbarScreen = true
                   }
        }
       
    }
}

//#Preview {
//    LoadingView()
//}
