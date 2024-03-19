//
//  ProfileSettingsView.swift
//  Yana
//
//  Created by serhat on 29.01.2024.
//

import SwiftUI

struct ProfileSettingsScreen: View {
    @ObservedObject var userViewModel = UsersViewModel()
    @ObservedObject var appViewModel :AppViewModel
    @State   var setting:ProfileSettings
    @State private  var username = ""
    @State private  var usermail = ""
    @State private var oldPassword = ""
    @State private var newPassword = ""

    var body: some View {
        
       
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            VStack{
                
                
                if setting == .userMail{
                    CustomTextField(hint: "E posta", tf: $usermail, iconName: "envelope").font(.system(size: screenWidth/40))
                    Text("Güncelle").font(.custom("Irish Grover", size: screenHeight/32))
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
                        ).onTapGesture {
                            userViewModel.updateEmail(newUserMail: usermail)
                            usermail = ""
                            
                            
                        }
                }
                else if setting == .userName{
                    CustomTextField(hint: "Kullanıcı Adı", tf: $username,iconName: "person").font(.system(size: screenWidth/40))
                    Text("Güncelle").font(.custom("Irish Grover", size: screenHeight/32))
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
                        ).onTapGesture {
                            userViewModel.updateUserName(tfUserName: username,appviewmodel: appViewModel)
                            username = ""
                        }
                    
                    }
                else if setting == .userPassword{
                    CustomTextField(hint: "Eski Parola", tf: $oldPassword, iconName: "lock").font(.system(size: screenWidth/40))
                    CustomTextField(hint: "Yeni Parola", tf: $newPassword, iconName: "lock").font(.system(size: screenWidth/40))
                    
                    Text("Güncelle").font(.custom("Irish Grover", size: screenHeight/32))
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
                        ).onTapGesture {
                            userViewModel.updatePassword(oldPassword: oldPassword, newPassword: newPassword)
                        }
                    Text(userViewModel.updateErrorMessage).foregroundColor(.red)
                    
                }
                else{
                    Text("Beklenmedik Bir Sorunla Karşılaşıldı")
                }
            }.padding(.vertical,screenHeight/5).padding(.horizontal,screenWidth/8)
        } .alert(isPresented: $userViewModel.showAlert) {
            Alert(
                title: Text("Güncelleme Mesajı"),
                message: Text(userViewModel.alertMessage),
                dismissButton: .default(Text("Tamam"))
            )
        }
        
  
        
       
    }
}

//#Preview {
//    ProfileSettingsScreen()
//}
