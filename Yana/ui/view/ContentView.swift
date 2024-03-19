//
//  ContentView.swift
//  Yana
//
//  Created by serhat on 23.01.2024.
//

import SwiftUI

struct ContentView: View { 
    @EnvironmentObject var viewModel :  AppViewModel
    @StateObject var userViewModel = UsersViewModel()
//    @StateObject var messageviewModel = ChatMessageViewModel()
    var body: some View {
        
        ZStack{
            if viewModel.currentScreen == .splash{
                SplashScreen(appViewModel: viewModel)
            }
            else if viewModel.currentScreen == .register{
                RegisterScreen( userViewModel: userViewModel, appViewModel: viewModel)
            }
            else if viewModel.currentScreen == .login{
                LoginScreen(userViewModel: userViewModel, appViewModel: viewModel)
            }
            else if viewModel.currentScreen == .loading{
                LoadingView(appViewModel: viewModel,userViewModel: userViewModel)
            }
            //                   else if viewModel.currentScreen == .networkPage{
            //                     networkErrorScreen()
            //                  }
            else if viewModel.currentScreen == .chatDetail{
                ChatDetailScreen(groupName: viewModel.ChatDetailPageList["groupName"] as! String, appViewModel: viewModel,vm: viewModel.ChatDetailPageList["mvm"] as! MessageManager)
//                    .transition(.move(edge: .leading))
//                    .animation(.linear)
            }
            else if viewModel.currentScreen == .tabbar{
              
                    TabBarScreen(appViewModel: viewModel, userViewModel: userViewModel)
//                    .transition(.move(edge: .leading))
//                    .animation(.bouncy(duration: 0.5))
              
              
            }
            else if viewModel.currentScreen == .callRoom{
                CallPage(appViewModel: viewModel, director: viewModel.callDetailList["director"] as! String, typeOfAddiction: viewModel.callDetailList["typeOfAddiction"] as! String)
                
            }
            
            
            else{
                Text("Bir Sorunla Karşılaşıldı.")
            }
        }
    }
           
    
    }


//#Preview {
//    ContentView()
//}
