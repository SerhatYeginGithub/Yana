//
//  LoginScreen.swift
//  Yana
//
//  Created by serhat on 27.12.2023.
//

import SwiftUI

struct LoginScreen: View {
//    @ObservedObject var messageViewModel : ChatMessageViewModel
    @ObservedObject var userViewModel:UsersViewModel
    @ObservedObject var appViewModel:AppViewModel
    @State private var rotationAngle: Angle = .degrees(45)
    @State private var rotationAngle2: Angle = .degrees(-45)
    @ObservedObject var viewModel = LoginScreenViewModel()
    let word = "İyi şeyler inandığında, daha iyi şeyler sabrettiğinde ve en iyi şeyler ise hiç vazgeçmediğinde gelir. - La Edri"
    @State private var isRegisterScreen = false
    var body: some View {
//        if isRegisterScreen {
////            RegisterScreen()
//        }
         if viewModel.isTabbarScreen {
             LoadingView(appViewModel: appViewModel,userViewModel: userViewModel)
        }
        else{
          
            GeometryReader {geometry in
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height
                ZStack{
                    Color(red: 234/255, green: 222/255, blue: 210/255).opacity(0.25)
                        .ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing:screenWidth/30){
                            
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
                            Spacer()
                            Text("GİRİŞ YAP")
                                .font(.custom("Irish Grover", size: screenHeight/20))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            CustomTextField(hint: "\(screenHeight)", tf: $viewModel.tfUserMail, iconName: "envelope").font(.system(size: screenWidth/40))
                            CustomTextField(hint: "Şifre", tf: $viewModel.tfUserPassword, iconName: "lock").font(.system(size: screenWidth/40))
                            Spacer()
                            Text("Giriş").font(.custom("Irish Grover", size: screenHeight/32))
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
                                .onTapGesture {
                                    viewModel.signIn(appViewModel: appViewModel)
                                }
                            
                            HStack{
                                Text("Henüz bir hesabın yok mu? ")
                                Spacer()
                                Text("Kayıt Ol").foregroundColor(.blue)
                                    .onTapGesture {
                                        appViewModel.currentScreen = .register
                                    }
                            }.font(.custom("Optima-BoldItalic", size: screenWidth/20))
                            
                            VStack {
                                Spacer()
                                Text(word).font(.custom("Irish Grover", size: screenWidth/20))
                                Spacer()
                            }
                            .alert(isPresented: $viewModel.showAlert) {
                                       Alert(
                                           title: Text("Kayıt Hatası"),
                                           message: Text(viewModel.alertMessage),
                                           dismissButton: .default(Text("Tamam"))
                                       )
                                   }
                            
                            Spacer()
                            
                            
                        }.padding(.horizontal,screenWidth/10).padding(.top,screenHeight/40)
                    }
                    
                }
            }
        }
    }
}
//#Preview {
//    LoginScreen()
//}
