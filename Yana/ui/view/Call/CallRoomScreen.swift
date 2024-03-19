//
//  CallRoomScreen.swift
//  Yana
//
//  Created by serhat on 23.02.2024.
//

import SwiftUI


struct CallRoomScreen:View {
    @State private var selectedOption = "Sigara Bağımlılığı"
    let options = ["Alışveriş Bağımlılığı", "Alkol Bağımlılığı", "Cinsel Bağımlılıklar","Kumar Bağımlılığı","Madde Bağımlılığı","Sigara Bağımlılığı","Teknoloji Bağımlılığı","Yeme Bağımlılığı"]
    @State var showCreateAlert = false
    @ObservedObject var appViewModel : AppViewModel
    @ObservedObject var vm = CallGroupManager()
    
    var body: some View {
        ZStack {
            NavigationView {
                GeometryReader {  geometry in
                    let screenWidth = geometry.size.width
                    let screenHeight = geometry.size.height
                    VStack {
                        
                        HStack{
                            Text("Bağımlılık Seçiniz:").font(.headline)
                            Picker("Select an option", selection: $selectedOption)
                            {
                                ForEach(options, id: \.self) { option in
                                    Text(option)
                                }
                            }.font(.headline)
                                .pickerStyle(.menu)
                            Spacer()
                        }.padding()
                        Spacer()
                        ShowRoomScreen(vm: vm, typeOfAddiction: getTypeOfAddiction(typeOfAddiction: selectedOption), screenWidth: screenWidth, screenHeight: screenHeight)
                            .navigationTitle("Sesli Sohbetler")
                        
                            .navigationBarItems(trailing:
                                                    Button(action: {showCreateAlert = true }, label: {
                                Image(systemName: "phone.fill.badge.plus").foregroundColor(.black)
                            }).font(.title2)
                            )
                        //                    }.onChange(of: vm.skipCallPage) { value in
                        //                        if value{
                        //                            appViewModel.callDetailList["director"] = UserDefaultsManager.shared.userId!
                        //                            appViewModel.currentScreen = .callRoom
                        //                        }
                        //                    }
                    }
                }.disabled(showCreateAlert)
                    .blur(radius: showCreateAlert ? 3 : 0)
                    .overlay(
                        Group {
                            if showCreateAlert{
                                CreateCallRoom(vm: vm, showCreateRoom: $showCreateAlert, appVM: appViewModel)
                            }
                        }
                    )
                
                
            }
            
        }
    }
    
    
}
