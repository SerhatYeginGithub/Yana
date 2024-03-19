//
//  SettingsScreen.swift
//  Yana
//
//  Created by serhat on 27.12.2023.
//

import SwiftUI
import FirebaseAuth

struct SettingsScreen: View {
    @ObservedObject var appViewModel :AppViewModel
    @ObservedObject var userViewModel :UsersViewModel
    @State private var userName = "Default User"
    var body: some View {
        
        ZStack {
            Color(red: 200/255, green: 162/255, blue: 200/255).opacity(0.5)
                .ignoresSafeArea()
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height
                
                
                NavigationView{
                    VStack() {
                        Form {
                          
                                Group {
                                    HStack{
                                        Spacer()
                                        HStack {
                                           
                                            Circle()
                                                .foregroundColor(.clear)
                                                .frame(width: screenWidth/5,height: screenWidth/5)
                                                .background(
                                                    Image(systemName: "person.crop.circle.fill")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                )
                                            Spacer()
                                            Text(userName).font(.largeTitle).bold()
                                            Spacer()
                                           
                                           
                                        }
                                        Spacer()
                                    }
                                }.navigationTitle("Ayarlar")
                                
                                    .onAppear(){
                                        userName = userViewModel.userInformation.first?.userName ?? "Nil User"
                                    }
                           
                            Section{
                                NavigationLink(destination: ProfileSettingsScreen(userViewModel: userViewModel, appViewModel: appViewModel, setting: .userMail)) {
                                    HStack{
                                        Image(systemName: "envelope.fill")
                                        Text("Kullanıcı E posta Değiştir")
                                    }
                                }
                                
                                NavigationLink(destination: ProfileSettingsScreen(userViewModel: userViewModel, appViewModel: appViewModel, setting: .userName)) {
                                    HStack{
                                        Image(systemName: "person.fill")
                                        Text("Kullanıcı Adını Değiştir")
                                    }
                                }
                           
                                NavigationLink(destination: ProfileSettingsScreen(userViewModel: userViewModel, appViewModel: appViewModel, setting: .userPassword)) {
                                    HStack{
                                        Image(systemName: "lock.fill")
                                        Text("Parolayı Değiştir")
                                    }
                                }
                            
                            }
                            Section{
                                Group{
                                    HStack{
                                        Spacer()
                                        Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                     
                                        Text("Oturumu Kapat").font(.headline)
                                        Spacer()
                                    }
                                }
                            }.onTapGesture {
                                userViewModel.performSignOut { success in
                                        if success {
                                            UserDefaultsManager.shared.clearUserData()
                                            userViewModel.userInformation.removeAll()
                                            appViewModel.currentScreen = .splash
                                            
                                        } else {
                                            userViewModel.alertMessage = "Çıkış Yapma İşlemi Başarısız"
                                            userViewModel.showAlert = true
                                        }
                                    }
                              
                            }
                            
                            Section{
                                HStack {
                                    Spacer()
                                    Text("Hesabı Sil").foregroundColor(.red).font(.headline)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


