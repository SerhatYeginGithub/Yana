//
//  CallManager.swift
//  Yana
//
//  Created by serhat on 18.03.2024.
//

import Foundation
import CallKit

class CallManager: NSObject, CXProviderDelegate {
    private let provider: CXProvider
    
    override init() {
        provider = CXProvider(configuration: CXProviderConfiguration(localizedName: "My App"))
        super.init()
        provider.setDelegate(self, queue: nil)
    }
    
    func startCall(handle: String) {
        let handle = CXHandle(type: .generic, value: handle)
        let startCallAction = CXStartCallAction(call: UUID(), handle: handle)
        let transaction = CXTransaction(action: startCallAction)
        requestTransaction(transaction)
    }
    
    func endCall() {
        let endCallAction = CXEndCallAction(call: UUID())
        let transaction = CXTransaction(action: endCallAction)
        requestTransaction(transaction)
    }
    
    private func requestTransaction(_ transaction: CXTransaction) {
        let callController = CXCallController()
        callController.request(transaction) { error in
            if let error = error {
                print("Error requesting transaction: \(error.localizedDescription)")
            } else {
                print("Transaction requested successfully")
            }
        }
    }
    
    // CXProviderDelegate methods
    func providerDidReset(_ provider: CXProvider) {
        // Actions to perform when provider is reset
    }
    
    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        // Actions to perform when call is started
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        // Actions to perform when call is ended
        action.fulfill()
    }
}
//
//// Kullanım örneği
//let callManager = CallManager()
//callManager.startCall(handle: "John Doe")
//
//// Aramayı sonlandırma
//callManager.endCall()
