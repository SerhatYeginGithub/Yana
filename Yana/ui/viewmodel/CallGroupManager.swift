//
//  CallManager.swift
//  Yana
//
//  Created by serhat on 15.03.2024.
//

import Foundation
import Firebase
import FirebaseFirestore

class CallGroupManager :ObservableObject {
    let db = Firestore.firestore()
    @Published var  roomList = [CallModel] ()
//    @Published var skipCallPage = false
    
    
    // Yeni Bir Sohbet Odası Oluşturulacak.
    
    func createCallRoom(roomName: String, typeOfAddiction: String, completion: @escaping (Bool) -> Void) {
        guard let userId = UserDefaultsManager.shared.userId else {
            print("Kullanıcı kimliği bulunamadı.")
            completion(false)
            return
        }
        
        let callRoomRef = db.collection("CallRooms").document(typeOfAddiction).collection("rooms")
        
        let data: [String: Any] = [
            "roomName": roomName,
            "director": userId,
            "members": [userId: UserDefaultsManager.shared.userName]
        ]
        
        callRoomRef.document(userId).setData(data) { error in
            if let error = error {
                print("Firebase'e callroom kayıt eklenirken hata oluştu: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Firebase'e call room başarıyla kayıt eklendi.")
                completion(true)
            }
        }
    }
    

    
    //Aktif Sohbet Odalarını Göster
    
    func getRooms(typeOfAddiction: String) {
       
        let callRoomRef = db.collection("CallRooms").document(typeOfAddiction).collection("rooms")
        
        callRoomRef.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error.debugDescription)")
                return
            }
            
            let liste = documents.compactMap { document -> CallModel? in
                do {
                    let callModel = try document.data(as: CallModel.self)
                    callModel.roomId = document.documentID
                    return callModel
                } catch {
                    print("Error decoding document into message: \(error)")
                    return nil
                }
            }
            
            
            DispatchQueue.main.async { [self] in
                self.roomList = liste.sorted { message1, message2 in
                    if message1.date == message2.date {
                        guard let userId1 = message1.roomId?.lowercased() else {
                            return false
                        }
                        guard let userId2 = message2.roomId?.lowercased() else {
                            return true
                        }
                        return userId1.lexicographicallyPrecedes(userId2)
                    } else {
                        return message1.date! > message2.date!
                    }
                }
          
                self.objectWillChange.send()
                
            }
        }
        
    }
    
    // Call Room çıkış yapma kodu
    
    func deleteCallRoom(typeOfAddiction: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let userId = UserDefaultsManager.shared.userId else {return}
        
        let callRoomRef = db.collection("CallRooms").document(typeOfAddiction).collection("rooms").document(userId)
        callRoomRef.delete { error in
            if let error = error {
                print("Sohbet Odası Silinirken Hata oluştu: \(error)")
                completion(false, error)
            } else {
               
                print("Sohbet Odası Başarılı bir şekilde silindi.")
            completion(true,nil)
            }
        }
    }
    
}
