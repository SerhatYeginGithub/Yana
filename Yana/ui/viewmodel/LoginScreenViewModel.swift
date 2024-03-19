//
//  LoginScreenViewModel.swift
//  Yana
//
//  Created by serhat on 15.01.2024.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class LoginScreenViewModel : ObservableObject{
    
    @Published var alertMessage = ""
    @Published var showAlert = false
    @Published var tfUserMail = ""
    @Published var tfUserPassword = ""
    @Published var isTabbarScreen = false 
    
    func signIn(appViewModel:AppViewModel) {
         Auth.auth().signIn(withEmail: self.tfUserMail, password: self.tfUserPassword) { authResult, error in
             let userid = authResult?.user.uid
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.showAlert = true
            } else {
    
                UserDefaultsManager.shared.email = self.tfUserMail
                UserDefaultsManager.shared.password = self.tfUserPassword
                UserDefaultsManager.shared.userId = userid
                appViewModel.currentScreen = .loading
                
            }
        }
    }
    
}
