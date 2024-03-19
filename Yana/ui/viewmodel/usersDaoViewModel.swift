//import Foundation
//import FirebaseDatabase
//
//class UserViewModel: ObservableObject {
//    @Published var userInformation: User?
//    var userId = UserDefaultsManager.shared.userId
//
//    func showUser() {
//      if userId == nil
//
//        let ref = Database.database().reference().child("Users").child(userId ?? "")
//        ref.observeSingleEvent(of: .value) { snapshot in
//            guard let userData = snapshot.value as? [String: Any] else {
//                print("Hata: Veri çekilemedi.")
//                return
//            }
//
//            let userName = userData["userName"] as? String ?? ""
//            let email = userData["email"] as? String ?? ""
//            let password = userData["password"] as? String ?? ""
//
//            let user = User(userName: userName, email: email, password: password)
//            
//            // DispatchQueue.main.async kullanarak @Published değişkeni güncelle
//            DispatchQueue.main.async {
//                self.userInformation = user
//            }
//        }
//    }
//}
//
//struct User {
//    let userName: String
//    let email: String
//    let password: String
//}
