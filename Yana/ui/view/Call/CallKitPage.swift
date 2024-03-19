//
//  CallKitPage.swift
//  Yana
//
//  Created by serhat on 18.03.2024.
//

import SwiftUI


struct CallKitPage:View {
    let callManager = CallManager()
        
        var body: some View {
            VStack {
                Button(action: {
                    callManager.startCall(handle: "John Doe")
                }) {
                    Text("Start Call")
                }
                
                Button(action: {
                    callManager.endCall()
                }) {
                    Text("End Call")
                }
            }
        }
}
