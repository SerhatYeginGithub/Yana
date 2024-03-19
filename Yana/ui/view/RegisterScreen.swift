//
//  RegisterScreen.swift
//  Yana
//
//  Created by serhat on 24.12.2023.
//

import SwiftUI

struct RegisterScreen: View {
//    @ObservedObject var messageViewModel : ChatMessageViewModel
    @ObservedObject var userViewModel : UsersViewModel
    @ObservedObject var appViewModel : AppViewModel
    @State private var rotationAngle: Angle = .degrees(45)
    @State private var rotationAngle2: Angle = .degrees(-45)
    @ObservedObject var viewModel = RegisterScreenViewModel()
    let word1 = "Bağımlılık hayatı daha "
    let word = "iyi gösterirken onun içini boşaltan her şeydir. -Clarissa P. Estes"
    @State private var isLoginScreen = false

   
    
    var body: some View {
        if viewModel.isTabbarScreen{
            LoadingView(appViewModel: appViewModel,userViewModel: userViewModel)
        }
        else {
            GeometryReader {geometry in
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height
                ZStack{
                    Color(red: 234/255, green: 222/255, blue: 210/255).opacity(0.25)
                        .ignoresSafeArea()
                  
                    ScrollView {
                        VStack(spacing:screenWidth/40){
                                
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: screenWidth/10,height: screenWidth/10)
                                    .background(
                                        Image("bird")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    )
                                
                                HStack{
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: screenWidth/5,height: screenWidth/5)
                                        .background(
                                            Image("chain")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        )
                                        .rotationEffect(rotationAngle)
                                    Spacer()
                                    Text("Yana'ya Hoşgeldiniz").font(.custom("Irish Grover", size: screenWidth/20))
                                    Spacer()
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: screenWidth/5,height: screenWidth/5)
                                        .background(
                                            Image("chain1")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        )
                                        .rotationEffect(rotationAngle2)
                                        
                                }
                         
                              
                                Text("KAYIT OL")
                                    .font(.custom("Irish Grover", size: screenHeight/20))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            CustomTextField(hint: "Kullanıcı Adı", tf: $viewModel.tfUserName,iconName: "person").font(.system(size: screenWidth/40))
                            CustomTextField(hint: "E posta", tf: $viewModel.tfUserMail, iconName: "envelope").font(.system(size: screenWidth/40))
                            CustomTextField(hint: "Parola", tf: $viewModel.tfUserPassword, iconName: "lock").font(.system(size: screenWidth/40))
                            CustomTextField(hint: "Parolayı Doğrula", tf: $viewModel.tfUP, iconName: "lock").font(.system(size: screenWidth/40))
                                Spacer()
                                Text("Kayıt OL").font(.custom("Irish Grover", size: screenHeight/32))
                                .onTapGesture {
                                    viewModel.register(appviewmodel: appViewModel)
                                }
                               
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: screenWidth/2)
                                   
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(red: 224/255, green: 255/255, blue:255/255))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.black, lineWidth: 2)
                                            )
                                    )
                           
                                HStack{
                                        Text("Zaten bir hesabın var mı? ")
                                    Spacer()
                                        Text("Giriş Yap").foregroundColor(.blue) .onTapGesture {
                                            appViewModel.currentScreen = .login
                                        }
                                }.font(.custom("Optima-BoldItalic", size: screenWidth/20))
                           
                            VStack {
                                Spacer()
                                Text(word1).font(.custom("Irish Grover", size: screenWidth/20))
                                Text(word).font(.custom("Irish Grover", size: screenWidth/20))
                                Spacer()
                            }
                                
                                Spacer()
                           
                                
                        }.padding(.horizontal,screenWidth/10).padding(.top,screenHeight/40)
                    }
                    // Alert gösterimi
                    .alert(isPresented: $viewModel.showAlert) {
                               Alert(
                                   title: Text("Kayıt Hatası"),
                                   message: Text(viewModel.alertMessage),
                                   dismissButton: .default(Text("Tamam"))
                               )
                           }
            
                }
            }
        }
       
    }
}

//#Preview {
//    RegisterScreen()
//}
