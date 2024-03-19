//
//  CallPage.swift
//  Yana
//
//  Created by serhat on 15.03.2024.
//

import SwiftUI

struct CallPage: View {
    @ObservedObject var appViewModel : AppViewModel
    @ObservedObject var vm = CallGroupManager()
    let userId = UserDefaultsManager.shared.userId
    var director : String
    var typeOfAddiction: String
    var body: some View {
        VStack{
            Text("Call Page ")
            Text("Odayı Kapat").foregroundColor(.red).onTapGesture {
                vm.deleteCallRoom(typeOfAddiction: typeOfAddiction) { result, _ in
                    if result {
                        appViewModel.currentScreen = .tabbar
                        
                    }
                }
               
            }

        }
    }
}

