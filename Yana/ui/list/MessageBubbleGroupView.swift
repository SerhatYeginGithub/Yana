//
//  MessageBubbleGroupView.swift
//  Yana
//
//  Created by serhat on 16.02.2024.
//

import SwiftUI


        struct MessageBubbleGroupView: View {
            let message: ChatMessageModel
            var messageUser : String
            @ObservedObject var viewModel: ChatMessageViewModel
            var screenHeight:Double
            var screenWidth:Double
            var groupName:String
            var body: some View {
                Group {
                    if message.userId == UserDefaultsManager.shared.userId! {
                        MessageBubbleView(isUser: true, message: message, messageUser:messageUser, screenWidth: screenWidth, screenHeight: screenHeight, groupName: groupName, viewModel: viewModel)
                    } else {
                        MessageBubbleView(isUser: false, message: message, messageUser:messageUser, screenWidth: screenWidth, screenHeight: screenHeight, groupName: groupName, viewModel: viewModel)
                    }
                }
//                .id(message.Id)
            }
        }

//#Preview {
//    MessageBubbleGroupView()
//}
