//
//  CreateCallRoomScreen.swift
//  Yana
//
//  Created by serhat on 15.03.2024.
//

import SwiftUI

 struct CreateCallRoom: View {
    @ObservedObject var vm :CallGroupManager
    @Binding var showCreateRoom :Bool
    @State private var tf = ""
    @State private var selectedOption = "Sigara Bağımlılığı"
    let options = ["Alışveriş Bağımlılığı", "Alkol Bağımlılığı", "Cinsel Bağımlılıklar","Kumar Bağımlılığı","Madde Bağımlılığı","Sigara Bağımlılığı","Teknoloji Bağımlılığı","Yeme Bağımlılığı"]
     @ObservedObject var  appVM :AppViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Sohbet Odası Kur")
                .font(.title)
                .bold()
            
            TextField("Grup Adı: ", text: $tf)
                .cornerRadius(8)
                .textFieldStyle(.roundedBorder)
                .ignoresSafeArea(.keyboard)
            
            Picker("Select an option", selection: $selectedOption)
            {
                ForEach(options, id: \.self) { option in
                    Text(option)
                }
            }.font(.headline)
            .pickerStyle(.menu)
            
            HStack {
                Spacer()
                
                Button("Vazgeç") {showCreateRoom = false}.font(.title3)
                    .foregroundColor(.red)
                    .padding()
                    .background(Color(.systemGray3).opacity(0.5))
                    .cornerRadius(20)
                
                Spacer()
                
                Button("Oluştur") {
        
                    vm.createCallRoom(roomName: tf, typeOfAddiction: getTypeOfAddiction(typeOfAddiction: selectedOption)) { success in
                        
                        if success{
                            appVM.callDetailList.removeAll()
                            appVM.callDetailList["director"] = UserDefaultsManager.shared.userId!
                            appVM.callDetailList["typeOfAddiction"] = getTypeOfAddiction(typeOfAddiction: selectedOption)
                            appVM.currentScreen = .callRoom
                        }
                    }
                    
                    
                }.font(.title3)
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color(.systemGray3).opacity(0.5))
                    .cornerRadius(20)
                
                Spacer()
            }
        }
        .padding()
        .background(
           
               Color(.systemGray6))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
        .padding()
    }
}


