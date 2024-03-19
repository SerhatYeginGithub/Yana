//
//  ResponsiveDeneme.swift
//  Yana
//
//  Created by serhat on 25.12.2023.
//

import SwiftUI

struct ResponsiveDeneme: View {
    @State private var rotationAngle: Angle = .degrees(45)
    @State private var rotationAngle2: Angle = .degrees(-45)
    @State private var tfUserName = ""
    @State private var tfUserMail = ""
    @State private var tfUserPassword = ""
    @State private var tfUP = ""
    let word = "Bağımlılık hayatı daha iyi gösterirken onun içini boşaltan her şeydir. -Clarissa P. Estes"
    
    let buttonColor = UIColor(red: 224, green: 255, blue: 255, alpha: 1.0)
    
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        ZStack{
            Color(red: 0.93, green: 0.93, blue: 0.93).opacity(0.25)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: sizeCategory == .accessibilityExtraExtraExtraLarge ? 40 : 20) {
                    Spacer()
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 80, height: 80)
                        .background(
                            Image("bird")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        )
                    
                    HStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 80, height: 80)
                            .background(
                                Image("chain")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            )
                            .rotationEffect(rotationAngle)
                        
                        Text("Yana'ya Hoşgeldiniz")
                            .font(.custom("Irish Grover", size: sizeCategory == .accessibilityExtraExtraExtraLarge ? 40 : 20))
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 80, height: 80)
                            .background(
                                Image("chain1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            )
                            .rotationEffect(rotationAngle2)
                    }
                    
                    Spacer()
                    
                    Text("KAYIT OL")
                        .font(.custom("Irish Grover", size: sizeCategory == .accessibilityExtraExtraExtraLarge ? 100 : 50))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomTextField(hint: "Kullanıcı Adı", tf: tfUserName, iconName: "person")
                    CustomTextField(hint: "E Posta", tf: tfUserMail, iconName: "envelope")
                    CustomTextField(hint: "Şifre", tf: tfUserPassword, iconName: "lock")
                    CustomTextField(hint: "Şifreyi Doğrula", tf: tfUP, iconName: "lock")
                    
                    Text("Kayıt OL")
                        .font(.custom("Irish Grover", size: sizeCategory == .accessibilityExtraExtraExtraLarge ? 40 : 20))
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: sizeCategory == .accessibilityExtraExtraExtraLarge ? 200 : 100)
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
                        Text("Giriş Yap").foregroundColor(.blue)
                    }
                    .font(.custom("Optima-BoldItalic", size: sizeCategory == .accessibilityExtraExtraExtraLarge ? 40 : 20))
                    
                    Spacer()
                    
                    Text(word)
                        .font(.custom("Irish Grover", size: sizeCategory == .accessibilityExtraExtraExtraLarge ? 40 : 20))
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}


#Preview {
    ResponsiveDeneme()
}
