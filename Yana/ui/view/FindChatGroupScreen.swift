//
//  FindChatGroupScreen.swift
//  Yana
//
//  Created by serhat on 31.01.2024.
//

import SwiftUI

struct FindChatGroupScreen: View {
    @State private var currentDate = Date()
    @State private var Chatgroups  = [ChatGroupModel]()
    @ObservedObject var chatViewModel :ChatViewModel
    @State private var liste = [ChatGroupModel]()
    @State private var show = false
    func formattedDate() -> String {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
         return dateFormatter.string(from: currentDate)
     }
    
    func check(MyGroupName:String) -> Bool {
        for group in chatViewModel.joinedGroups {
            if let groupName = group.groupName, groupName.contains(MyGroupName) {
                return false
            }
        }
        return true
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            ZStack { // veya ZStack
                NavigationView {
                    List {
                        
                        ChatGroupView(groupName: "smoking", groupIcon: "smoking", size: screenWidth*0.2, show: check(MyGroupName: "smoking"))
                            .onTapGesture {
                                if check(MyGroupName: "smoking"){
                                   chatViewModel.joinGroupFirestore(group: "smoking",date: formattedDate())
                                }                             }
                        
                        ChatGroupView(groupName: "alcohol", groupIcon: "alcohol", size: screenWidth*0.2, show: check(MyGroupName: "alcohol"))
                            .onTapGesture {
                                if check(MyGroupName: "alcohol"){
                                    chatViewModel.joinGroupFirestore(group: "alcohol",date: formattedDate())
                                }                            }
                        
                        ChatGroupView(groupName: "drug", groupIcon: "drug", size: screenWidth*0.2, show: check(MyGroupName: "drug"))
                            .onTapGesture {
                                if check(MyGroupName: "drug"){
                                    chatViewModel.joinGroupFirestore(group: "drug",date: formattedDate())
                                }
                            }
                        
                        ChatGroupView(groupName: "gambling", groupIcon: "gambling", size: screenWidth*0.2, show: check(MyGroupName: "gambling"))
                            .onTapGesture {
                                if check(MyGroupName: "gambling"){
                                    chatViewModel.joinGroupFirestore(group: "gambling",date: formattedDate())
                                }
                               
                            }
                        
                        ChatGroupView(groupName: "shopping", groupIcon: "shopping", size: screenWidth*0.2, show: check(MyGroupName: "shopping"))
                            .onTapGesture {
                                if check(MyGroupName: "shopping"){
                                   chatViewModel.joinGroupFirestore(group: "shopping",date: formattedDate())
                                }                             }
                        ChatGroupView(groupName: "technology", groupIcon: "technology", size: screenWidth*0.2, show: check(MyGroupName: "technology"))
                            .onTapGesture {
                                if check(MyGroupName: "technology"){
                                   chatViewModel.joinGroupFirestore(group: "technology",date: formattedDate())
                                }                             }
                        
                        ChatGroupView(groupName: "food", groupIcon: "food", size: screenWidth*0.2, show: check(MyGroupName: "food"))
                            .onTapGesture {
                                if check(MyGroupName: "food"){
                                   chatViewModel.joinGroupFirestore(group: "food",date: formattedDate())
                                }                             }
                        
                        ChatGroupView(groupName: "sex", groupIcon: "sex", size: screenWidth*0.2, show: check(MyGroupName: "sex"))
                            .onTapGesture {
                                if check(MyGroupName: "sex"){
                                   chatViewModel.joinGroupFirestore(group: "sex",date: formattedDate())
                                }                             }
                        
                        
                    }
                    .navigationBarTitle("Destek Grupları")
                    .alert(isPresented: $chatViewModel.showAlert) {
                        Alert(
                            title: Text(chatViewModel.alertTitle),
                            message: Text(chatViewModel.alertMessage),
                            dismissButton: .default(Text("Tamam"))
                        )
                    }.onAppear(){
                        
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                            // Her saniyede bir timer tetiklendiğinde, currentDate'i güncelle
                            currentDate = Date()
                        }
                    }
                }
            }
        }.onAppear(){
            liste = chatViewModel.joinedGroups
        }
    }
}

#Preview {
    FindChatGroupScreen(chatViewModel: ChatViewModel())
}
