//
//  ShowRoomScreen.swift
//  Yana
//
//  Created by serhat on 15.03.2024.
//

import SwiftUI

struct ShowRoomScreen: View {
    @ObservedObject var vm :CallGroupManager
    var typeOfAddiction :String
    var screenWidth :Double
    var screenHeight :Double
  
    init(vm: CallGroupManager, typeOfAddiction: String, screenWidth: Double, screenHeight: Double) {
        self.vm = vm
        self.typeOfAddiction = typeOfAddiction
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        vm.getRooms(typeOfAddiction: typeOfAddiction)
    }
    
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(vm.roomList){ room in
                    if room.members?.count != 0 {
                        CallRoomItems(typeOfAddiction: typeOfAddiction, roomName: room.roomName ?? "default", JoinedMemberCount: room.members?.count ?? 0, screenWidth: screenWidth, screenHeight: screenHeight).padding(.vertical,25)
                    }
                   
                }
            }
            Spacer()
        }
    }
}

//#Preview {
//    ShowRoomScreen()
//}
