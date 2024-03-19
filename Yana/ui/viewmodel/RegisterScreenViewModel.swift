import Foundation
import FirebaseAuth
import FirebaseDatabase

class RegisterScreenViewModel: ObservableObject {
    @Published var alertMessage = ""
    @Published var showAlert = false
    @Published var tfUserName = ""
    @Published var tfUserMail = ""
    @Published var tfUserPassword = ""
    @Published var tfUP = ""
    @Published var isTabbarScreen = false
    func kayitOl(email: String, password: String, userName: String,appviewmodel:AppViewModel) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                self.alertMessage = error.localizedDescription
                self.showAlert = true
                // Firebase Authentication'dan kullanıcıyı sil
                return
            }
            
            // Kullanıcı başarıyla kaydedildi
            print("Kullanıcı kaydedildi.")
            
            if let uid = authResult?.user.uid {
                // Realtime Database'e kullanıcı bilgilerini ekle
                self.kayitEkleFirebase(uid: uid, userName: userName, email: email, password: password,appviewModel: appviewmodel)
            }
            
            // İsterseniz burada başka işlemler yapabilirsiniz, örneğin kullanıcıya bir doğrulama e-postası gönderebilirsiniz.
        }
    }

    func kayitEkleFirebase(uid: String, userName: String, email: String, password: String,appviewModel:AppViewModel) {
        let ref = Database.database().reference().child("Users").child(uid)
        let userData: [String: Any] = [
            "userName": userName,
            "email": email,
            "password": password
        ]
        
        ref.setValue(userData) { (error, _) in
            if let error = error {
                print("Firebase'e kayıt eklenirken hata oluştu: \(error.localizedDescription)")
                
                // Firebase Authentication'dan kullanıcıyı sil
                self.silFirebaseUser()
                
                // Hata mesajını güncelle
                self.alertMessage = "Firebase Database hatası: \(error.localizedDescription)"
            } else {
                print("Firebase'e başarıyla kayıt eklendi.")
                UserDefaultsManager.shared.email = email
                UserDefaultsManager.shared.password = password
                UserDefaultsManager.shared.userName = userName
                UserDefaultsManager.shared.userId = uid
                appviewModel.currentScreen = .loading
            }
        }
    }

    func silFirebaseUser() {
        if let user = Auth.auth().currentUser {
            user.delete { error in
                if let error = error {
                    print("Kullanıcı silinirken hata oluştu: \(error.localizedDescription)")
                } else {
                    print("Kullanıcı başarıyla silindi.")
                }
            }
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

    
    func register(appviewmodel:AppViewModel){
        var kullaniciBilgi = [String]()
        kullaniciBilgi.append(self.tfUserName)
        kullaniciBilgi.append(self.tfUserMail)
        kullaniciBilgi.append(self.tfUserPassword)
        print(kullaniciBilgi)
        if self.tfUserPassword == self.tfUP{
            
            kullaniciAdiKontrolEt(userName: tfUserName) { (kullanilabilir) in
                if kullanilabilir {
                    print("Kullanıcı adı kullanılabilir.")
                    self.kayitOl(email: self.tfUserMail, password: self.tfUserPassword, userName: self.tfUserName,appviewmodel: appviewmodel)
                } else {
                    print("Kullanıcı adı daha önce alınmış.")
                    self.alertMessage = "Kullanıcı adı daha önce alınmış."
                    self.showAlert = true
                    return
                }
            }
          
          
            
        }
        
        else
        {
            self.alertMessage = "Şifreler Uyuşmuyor."
            showAlert = true
            return
        }
    }
}
