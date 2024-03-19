////
////  VoiceDormApp.swift
////  Yana
////
////  Created by serhat on 18.03.2024.
////
//
//import Foundation
//import SwiftUI
//import StreamVideo
//
//@main
//struct VoiceDormApp: App {
//    @State var call: Call
//    @ObservedObject var state: CallState
//    @State private var callCreated: Bool = false
//
//    private var client: StreamVideo
//    private let apiKey: String = "" // The API key can be found in the Credentials section
//    private let userId: String = "" // The User Id can be found in the Credentials section
//    private let token: String = "" // The Token can be found in the Credentials section
//    private let callId: String = "" // The CallId can be found in the Credentials section
//
//    init() {
//        let user = User(
//            id: userId,
//            name: "Martin", // name and imageURL are used in the UI
//            imageURL: .init(string: "https://getstream.io/static/2796a305dd07651fcceb4721a94f4505/a3911/martin-mitrevski.webp")
//        )
//
//        // Initialize Stream Video client
//        self.client = StreamVideo(
//            apiKey: apiKey,
//            user: user,
//            token: .init(stringLiteral: token)
//        )
//
//        // Initialize the call object
//        let call = client.call(callType: "audio_room", callId: callId)
//
//        self.call = call
//        self.state = call.state
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            VStack {
//                if callCreated {
//                    Text("Audio Room \(call.callId) has \(call.state.participantCount) participants")
//                        .font(.system(size: 30))
//                        .foregroundColor(.blue)
//                } else {
//                    Text("loading...")
//                }
//            }.task {
//                Task {
//                    guard !callCreated else { return }
//                    try await call.join(
//                        create: true,
//                        options: .init(
//                            members: [
//                                .init(userId: "john_smith"),
//                                .init(userId: "jane_doe"),
//                            ],
//                            custom: [
//                                "title": .string("SwiftUI heads"),
//                                "description": .string("Talking about SwiftUI")
//                            ]
//                        )
//                    )
//                    callCreated = true
//                }
//            }
//        }
//    }
//}
