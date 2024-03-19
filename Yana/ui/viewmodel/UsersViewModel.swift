//
//  UsersViewModel.swift
//  Yana
//
//  Created by serhat on 29.01.2024.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class UsersViewModel:ObservableObject{
    @Published var userInformation = [Users]()
    @Published var updateErrorMessage = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var updateApp = false

    func fetchData() {
        let userId = UserDefaultsManager.shared.userId
        let ref = Database.database().reference().child("Users").child(userId!)
        
        let group = DispatchGroup() // Dispatch Group oluşturuldu
        
        group.enter() // Dispatch Group'a bir işlem eklendi
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if let value = snapshot.value as? [String: Any] {
                let userName = value["userName"] as! String
                let userMail = value["email"] as! String
                let userPassword = value["password"] as! String
                let user = Users(userName: userName, userMail: userMail, userPassword: userPassword)
                self.userInformation.removeAll()
                self.userInformation.append(user)
            } else {
                print("Error: Cannot parse snapshot value")
            }
            
            group.leave() // Dispatch Group'taki işlem tamamlandı
        })
        
        group.notify(queue: .main) {
            for user in self.userInformation {
                UserDefaultsManager.shared.userName = user.userName
                print(user.userName)
                print(user.userMail)
                print(user.userPassword)
                
            }
        }
    }
    
    
    func showuserInformation(){
        
        print("showuserfonksiyonu")
        for user in self.userInformation {
            
            print(user.userName)
            print(user.userMail)
            print(user.userPassword)
            
        }
    }

    
    func updatePassword(oldPassword:String,newPassword:String) {
       let myEmail = UserDefaultsManager.shared.email!
       let myPassword = UserDefaultsManager.shared.password!
        if myPassword == oldPassword{
    
       guard let currentUser = Auth.auth().currentUser else {
           return
       }
       
       let credential = EmailAuthProvider.credential(withEmail: myEmail, password: myPassword)
       
            currentUser.reauthenticate(with: credential) { [self] _, error in
                if let error = error {
                    print("Kimlik doğrulama hatası: \(error.localizedDescription)")
                } else {
                    
                    if !newPassword.isEmpty {
                        currentUser.updatePassword(to: newPassword) { error in
                            if let error = error {
                                print("Parola güncellenirken hata oluştu: \(error.localizedDescription)")
                                self.updateErrorMessage = error.localizedDescription
                            } else {
                                print("Parola başarıyla güncellendi.")
                                let userId = UserDefaultsManager.shared.userId
                                let userRef = Database.database().reference().child("Users").child(userId!)
                                userRef.child("password").setValue(newPassword) { error, _ in
                                       if let error = error {
                                           print("Parola güncelleme hatası: \(error.localizedDescription)")
                                       } else {
                                           UserDefaultsManager.shared.password = newPassword
                                           self.alertMessage = "Parola Başarıyla Güncellendi."
                                           self.showAlert = true
                                       }
                                   }
                                
                            }
                        }
                    }
                }
            }
       }
        else{
            self.updateErrorMessage = "Lütfen mevcut şifrenizi doğru girdiğinizden emin olun"
        }
   }
    
    func kullaniciAdiKontrolEt(userName: String, completion: @escaping (Bool) -> Void) {
        let ref = Database.database().reference().child("Users")

        ref.queryOrdered(byChild: "userName").queryEqual(toValue: userName).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                // Kullanıcı adı daha önce alınmış
                completion(false)
            } else {
                // Kullanıcı adı kullanılabilir
                completion(true)
            }
        }
    }
    

    
    
    
    
    
    
    func updateUserName(tfUserName:String,appviewmodel:AppViewModel){
        if !tfUserName.isEmpty{
            
            kullaniciAdiKontrolEt(userName: tfUserName) { (kullanilabilir) in
                if kullanilabilir {
                    print("Kullanıcı adı kullanılabilir.")
                    let userId = UserDefaultsManager.shared.userId
                    let userRef = Database.database().reference().child("Users").child(userId!)
                    userRef.child("userName").setValue(tfUserName) { error, _ in
                        if let error = error {
                            print("Kullanıcı Adı Güncelleme Hatası: \(error.localizedDescription)")
                        } else {
                            
                            self.alertMessage = "Kullanıcı Adı Başarıyla Güncellendi."
                            self.showAlert = true
                            self.fetchData()
                            
                        }
                    }
                    
                } else {
                    print("Kullanıcı adı daha önce alınmış.")
                    self.alertMessage = "Kullanıcı adı daha önce alınmış."
                    self.showAlert = true
                    return
                }
            }
            
        }
        else{
            self.alertMessage = "Kullanıcı Adı Boş Bırakılamaz."
            self.showAlert = true
        }
    }
    
    func updateEmail(newUserMail:String) {
        let myEmail = UserDefaultsManager.shared.email!
        let myPassword = UserDefaultsManager.shared.password!
        
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: myEmail, password: myPassword)
        
        currentUser.reauthenticate(with: credential) { [self] _, error in
            if let error = error {
                print("Kimlik doğrulama hatası: \(error.localizedDescription)")
            } else {
                currentUser.updateEmail(to: newUserMail) { error in
                    if let error = error {
                        print("E-posta güncellenirken hata oluştu: \(error.localizedDescription)")
                    } else {
                        let userId = UserDefaultsManager.shared.userId
                        let userRef = Database.database().reference().child("Users").child(userId!)
                        userRef.child("email").setValue(newUserMail) { error, _ in
                               if let error = error {
                                   print("E-posta güncelleme hatası: \(error.localizedDescription)")
                               } else {
                                   self.alertMessage = "E posta Başarıyla Güncellendi."
                                   self.showAlert = true
                               }
                           }
                    }
                }
            }
            
        }
    }
    
    func performSignOut(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch let signOutError as NSError {
            print("Çıkış yaparken hata oluştu: \(signOutError.localizedDescription)")
            completion(false)
        }
    }
    
    
 
    
}



