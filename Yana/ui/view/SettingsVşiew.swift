////
////  SettingsVşiew.swift
////  Yana
////
////  Created by serhat on 29.01.2024.
////
//
//import SwiftUI
//
//struct SettingsVs_iew: View {
//    
//    var body: some View {
//        
//        
//        GeometryReader { geometry in
//            let screenWidth = geometry.size.width
//            let screenHeight = geometry.size.height
//            
//            
//            NavigationView{
//                VStack(alignment: .center) {
//                    Form {
//                        NavigationLink(destination: ProfileSettingsScreen()) {
//                            Group {
//                                HStack{
//                                    Spacer()
//                                    HStack {
//                                       
//                                        Circle()
//                                            .foregroundColor(.clear)
//                                            .frame(width: screenWidth/5,height: screenWidth/5)
//                                            .background(
//                                                Image(systemName: "person.crop.circle.fill")
//                                                    .resizable()
//                                                    .aspectRatio(contentMode: .fit)
//                                            )
//                    Spacer()
//                                        Text("userName").font(.system(size: screenHeight/25)).bold()
//                                        Spacer()
//                                       
//                                       
//                                    }
//                                    Spacer()
//                                }
//                            }.navigationTitle("Ayarlar")
//                            
//                          
//                        }
//                        Section{
//                            NavigationLink(destination: ProfileSettingsScreen()) {
//                                Text("Kullanıcı Adını Değiştir")
//                            }
//                            Text("Kullanıcı E posta Değiştir")
//                            Text("Parolayı Değiştir")
//                        }
//                        Section{
//                            Group{
//                                HStack{
//                                    Spacer()
//                                    Image(systemName: "rectangle.portrait.and.arrow.right.fill")
//                                 
//                                    Text("Oturumu Kapat").font(.headline)
//                                    Spacer()
//                                }
//                            }
//                        }.onTapGesture {
//                            
//                        }
//                        
//                        Section{
//                            HStack {
//                                Spacer()
//                                Text("Hesabı Sil").foregroundColor(.red).font(.headline)
//                                Spacer()
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//#Preview {
//    SettingsVs_iew()
//}
