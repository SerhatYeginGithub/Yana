//
//  ChatScreen.swift
//  Yana
//
//  Created by serhat on 15.01.2024.
//

import SwiftUI   

struct ChatScreen: View {
    
    @State private var showAlert = false
    @State private var textValue = ""
   
    @StateObject var chatViewModel = ChatViewModel()
    @State var showCreatePage = false
    @State var showFindPage = false
    @State private var yourGroups = [ChatGroupModel]()
    @State private var currentDate = Date()
    @ObservedObject var appViewModel: AppViewModel
    @State private var liste = [ChatGroupModel]()
    @State private var showDetails = false
    @State private var index :IndexSet?
    @State private var showDeleteAlert = false
    @ObservedObject var mvm = MessageManager()
    @State private var groupName = ""
    @State private var createGroupAlert = false

    
    func deleteGroup(at offsets: IndexSet) {
        for index in offsets {
            if index < chatViewModel.joinedGroups.count {
                let group = chatViewModel.joinedGroups[index]
                print("\(group.groupName ?? "") silindi")
                chatViewModel.deleteGroupFirestore(group: group)
            }
        }
    }
    
    
    var body: some View {
        
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            NavigationView{
                ZStack(alignment: .center){
                    
                    List {
                        ForEach(chatViewModel.joinedGroups) { groups in
                            
                            let value = groups.isMember ?? false
                            if value {
                                
                                HStack{
                                    ChatGroupView(groupName: groups.groupName ?? "default", groupIcon: groups.groupName ?? "default", size: screenWidth*0.2, show: true)
                                    Spacer()
                                    Image(systemName: "chevron.right").font(.title)
                                }.padding(.trailing)
                                    .onTapGesture {
                                        mvm.getOldMessages(group: groups.groupName!) { result in
                                            if !result.isEmpty{
                                                
                                                    appViewModel.ChatDetailPageList.removeAll()
                                                    appViewModel.ChatDetailPageList["groupName"] = groups.groupName ?? "default"
                                                    appViewModel.ChatDetailPageList["mvm"] = mvm
                                                    appViewModel.currentScreen = .chatDetail
                                                
                                                }
                            
                                            else {
                                                appViewModel.ChatDetailPageList.removeAll()
                                                appViewModel.ChatDetailPageList["groupName"] = groups.groupName ?? "default"
                                                appViewModel.ChatDetailPageList["mvm"] = mvm
                                                appViewModel.currentScreen = .chatDetail
                                            } 
                                        }
                                        
                                    }
                                
                            }
                        }
                        .onDelete(perform: { indexSet in
                            index = indexSet
                            showDeleteAlert = true
                        })
                        
                        
                        .alert(isPresented: $showDeleteAlert) {
                            Alert(
                                title: Text("Silme İşlemi"),
                                message: Text("Grubu Silmek İstediğinize Emin Misiniz ?"),
                                primaryButton: .destructive(
                                    Text("Sil").foregroundColor(.red),
                                    action: {
                                        guard let index = index else {
                                            return
                                        }
                                        deleteGroup(at: index)
                                    }
                                ),
                                secondaryButton: .cancel(
                                    Text("İptal"),
                                    action: { }
                                )
                            )
                        }
                        
                    }.navigationBarTitle("Sohbetler")
                        .navigationBarItems(trailing:
                            Image(systemName: "person.3.fill").onTapGesture {
                                showFindPage = true
                            }
                        )
                    
                        .sheet(isPresented: $showFindPage) {
                            FindChatGroupScreen(chatViewModel: chatViewModel)
                        }
                    
                    
                }.onAppear() {
                    
                    chatViewModel.getJoinedGroups()
                    
                }
            }

        }
    }
}
