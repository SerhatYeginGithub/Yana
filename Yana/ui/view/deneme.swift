////
////  deneme.swift
////  Yana
////
////  Created by serhat on 27.12.2023.
////
//
//import SwiftUI
//
//struct deneme: View {
//    @State private var selectedSection = 1
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            TabView(selection: $selectedSection) {
//                HomeScreen()
//                    .tabItem {
//                        VStack {
//                            Image(systemName: "house.fill")
//                                .font(.system(size: 24))
//                            Text("Anasayfa")
//                                .font(.system(size: 12))
//                        }
//                    }
//                    .tag(0)
//                
//                Text("Sohbetler")
//                    .tabItem {
//                        VStack {
//                            Image(systemName: "message.fill")
//                                .font(.system(size: 24))
//                            Text("Sohbetler")
//                                .font(.system(size: 12))
//                        }
//                    }
//                    .tag(1)
//                
//                Text("Kriz Sayfası")
//                    .tabItem {
//                        VStack {
//                            Image(systemName: "light.beacon.max")
//                                .font(.system(size: 24))
//                            Text("Kriz Anı")
//                                .font(.system(size: 12))
//                        }
//                    }
//                    .tag(2)
//                
//                Text("Aramalar")
//                    .tabItem {
//                        VStack {
//                            Image(systemName: "phone.fill")
//                                .font(.system(size: 24))
//                            Text("Aramalar")
//                                .font(.system(size: 12))
//                        }
//                    }
//                    .tag(3)
//                
//                Text("Ayarlar")
//                    .tabItem {
//                        VStack {
//                            Image(systemName: "gear")
//                                .font(.system(size: 24))
//                            Text("Ayarlar")
//                                .font(.system(size: 12))
//                        }
//                    }
//                    .tag(4)
//            }
//            .tabViewStyle(DefaultTabViewStyle())
//            .background(Color.white)
//            
//            Rectangle()
//                .frame(height: 1)
//                .foregroundColor(.gray)
//        }
//        .overlay(
//            RoundedRectangle(cornerRadius: 16)
//                .stroke(Color.gray, lineWidth: 1)
//        )
//        .padding(.horizontal, 16)
//        .background(Color.white)
//        .clipShape(RoundedRectangle(cornerRadius: 16))
//        .padding(.horizontal)
//        .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: -2)
//        .accentColor(Color(red: 160/255, green: 82/255, blue: 45/255).opacity(1))
//    }
//}
//#Preview {
//    deneme()
//}
