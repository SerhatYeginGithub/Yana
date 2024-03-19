//
//  ChatViewModel.swift
//  Yana
//
//  Created by serhat on 31.01.2024

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatViewModel:ObservableObject{
    
    @Published var alertMessage = ""
    @Published var showAlert = false
    @Published var joinedGroups = [ChatGroupModel]()
    @Published var alertTitle = ""
    @Published var bubblePosition:BubblePosition = .right
    @Published var showChatDetailScreen = false 
    
    let db = Firestore.firestore()
    
    func joinGroupFirestore(group: String, date: String) {
        guard let userId = UserDefaultsManager.shared.userId else {
            return
        }
        

        let userRef = db.collection("ChatGroups").document("Members").collection(userId).document(group)
        
        let data: [String: Any] = [
            "groupName": group,
            "isMember": true,
            "groupDate": date,
            "memberName": UserDefaultsManager.shared.userName!
        ]
        
        userRef.setData(data) { error in
            if let error = error {
                print("Firestore'e kayıt eklenirken bir hata oluştu: \(error.localizedDescription)")
                // Hata durumunda yapılacak işlemler
            } else {
                print("Firestore'e başarıyla kayıt eklendi.")
                self.saveGroupMembers(group: group, date: date)
                // Firestore'daki veriler güncellendikten sonra tetiklenen olayı bekleyin
                // ve verileri güncelleyin.
                self.getJoinedGroups()
                self.alertTitle = "Başarılı"
                self.alertMessage = "Gruba Katılım Sağlandı."
                self.showAlert = true
                
                print("joinGroup tamamlandı")
            }
        }
    }
    
    
    func getJoinedGroups() {
        guard let userId = UserDefaultsManager.shared.userId else {
            print("Kullanıcı kimliği bulunamadı.")
            return
        }
        
        print("userid: \(userId)")
      
        let groupRef = db.collection("ChatGroups").document("Members").collection(userId)
        
        groupRef.addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found.")
                return
            }
            
            self.joinedGroups = documents.compactMap { document -> ChatGroupModel? in
                do {
                    let groupModel = try document.data(as: ChatGroupModel.self)
                    return groupModel
                } catch {
                    print("Error decoding document into message: \(error)")
                    return nil
                }
            }
            
            self.joinedGroups = self.joinedGroups.sorted(by: { $1.groupDate! < $0.groupDate! })
        }
    }
    
    
    func deleteGroupFirestore(group: ChatGroupModel) {
        guard let userId = UserDefaultsManager.shared.userId else {
            print("Kullanıcı kimliği bulunamadı.")
            return
        }
        
      
        let groupRef = db.collection("ChatGroups").document("Members").collection(userId).document(group.groupName ?? "default")
        
        groupRef.delete { error in
            if let error = error {
                print("Firestore'dan grup silinirken bir hata oluştu: \(error.localizedDescription)")
                // Hata durumunda yapılacak işlemler
            } else {
                print("Firestore'dan grup başarıyla silindi.")
                
                // Firestore'daki veriler güncellendikten sonra tetiklenen olayı bekleyin
                // ve verileri güncelleyin.
                self.getJoinedGroups()
                
            }
        }
    }
    
    
    func saveGroupMembers(group: String, date: String) {
        guard let userId = UserDefaultsManager.shared.userId else {
            return
        }
        

        let userRef = db.collection("ChatGroups").document("GroupMembers").collection(group).document(userId)
        
        let data: [String: Any] = [
            "memberName": UserDefaultsManager.shared.userName!
        ]
        
        userRef.setData(data) { error in
            if let error = error {
                print("Firestore userName grup için  kayıt eklenirken bir hata oluştu: \(error.localizedDescription)")
                // Hata durumunda yapılacak işlemler
            } else {
                print("Firestore'e username group için başarıyla kayıt eklendi.")
                
                // Firestore'daki veriler güncellendikten sonra tetiklenen olayı bekleyin
                // ve verileri güncelleyin.
               
            }
        }
    }
    

    
    
    }
 
