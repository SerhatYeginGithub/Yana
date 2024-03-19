//
//  CreateChatGroupScreen.swift
//  Yana
//
//  Created by serhat on 31.01.2024.
//

import SwiftUI

struct CreateChatGroupScreen: View {
    @State var tf = ""
    let groupTopic = ["Sigara","Alkol","Madde","Kumar"]
    @State private var selected = 0
    var body: some View {
        GeometryReader {geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            VStack(spacing:screenHeight/15){
                Spacer()
                Text("Destek Grubu Oluştur").font(.title).bold()
             
             CustomTextField(hint: "Grup Adı", tf: $tf, iconName: "person.3.fill")
                  Picker(selection: $selected, label: Text("Bağımlılık")) {
                      ForEach(0 ..< groupTopic.count) {
                          Text(self.groupTopic[$0])
                      }
                  }
                Text("Grup Oluştur").font(.title2).bold()
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: screenWidth/2)
                
                
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 251/255, green: 174/255, blue:210/255))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    )
                    .onTapGesture {
                       
                    }
                Spacer()
            }.padding(.horizontal,screenWidth/8).padding(.vertical,screenHeight/8)
        }
    }
}

#Preview {
    CreateChatGroupScreen()
}
