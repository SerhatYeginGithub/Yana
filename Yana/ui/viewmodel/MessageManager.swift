import Foundation
import SwiftUI
import FirebaseDatabaseInternal
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
class MessageManager: ObservableObject {
    let userId = UserDefaultsManager.shared.userId
    @Published private(set)var messageList = [ChatMessageModel]()
    @Published private(set)var messageUserName = ""
    @Published var lastMessageId = ""
    @Published var messageUserNameList = [String:String]()
    @Published var selectedMessageId  = ""
    @Published var messageDateList : Set<String> = []
    @Published var selectedMessageInformation = [String:String]()
    @Published var isAnswerMessage = false
    @Published var deletedMessages = [String]()
    let db = Firestore.firestore()
    @Published var oldMessageList = [ChatMessageModel]()
    @Published var oldMessageDateList : Set<String> = []
    @Published var veryOldMessageDateList : Set<String> = []
    @Published var userNameList : [String:String] = [:]
    
    init(){
        
    }
    
    // firebase veri gönderme
    func sendMessage(yourMessage: String, groupName: String, messageDate: Date,userName :String) {
        guard let userId = UserDefaultsManager.shared.userId else {
            print("Kullanıcı kimliği bulunamadı.")
            return
        }
        let chatGroupsRef = db.collection("ChatGroups").document("Messages")
        
        let data: [String: Any] = [
            "userName": userName,
            "userId": userId,
            "message": yourMessage,
            "date": messageDate,
            "answeredMessageInformation": [self.selectedMessageInformation]
        ]
        chatGroupsRef.collection(groupName).addDocument(data: data) { error in
            if let error = error {
                print("Firebase'e kayıt eklenirken hata oluştu: \(error.localizedDescription)")
            } else {
                print("Firebase'e başarıyla kayıt eklendi.")
                self.isAnswerMessage = false
                self.selectedMessageInformation = [:]
            }
        }
        
    }
    
    
    // firebaseden veri silme
    
    func deleteMessage(messageId: String, groupName: String) {
        let chatGroupsRef = db.collection("ChatGroups").document("Messages").collection(groupName)
        
        chatGroupsRef.document(messageId).delete { error in
            if let error = error {
                print("Hata oluştu: \(error)")
            } else {
               
                print("Mesaj başarıyla silindi")
                
                
            }
        }
    }
    
    
    
    
    // firebaseden verileri alma
    
    func getMessage(group: String) {
        guard !group.isEmpty else {
            return
        }
        
        let startDate = self.oldMessageList.last?.date// Belirli bir tarih
        let chatGroupsRef = db.collection("ChatGroups").document("Messages").collection(group).whereField("date", isGreaterThan: startDate ?? Date.now)
        
        chatGroupsRef.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error.debugDescription)")
                return
            }
            
            let liste = documents.compactMap { document -> ChatMessageModel? in
                do {
                    let messageModel = try document.data(as: ChatMessageModel.self)
                    messageModel.messageId = document.documentID
                    return messageModel
                } catch {
                    print("Error decoding document into message: \(error)")
                    return nil
                }
            }
            
            
            DispatchQueue.main.async { [self] in
                self.messageList = liste.sorted { message1, message2 in
                    if message1.date == message2.date {
                        guard let userId1 = message1.userId?.lowercased() else {
                            return false
                        }
                        guard let userId2 = message2.userId?.lowercased() else {
                            return true
                        }
                        return userId1.lexicographicallyPrecedes(userId2)
                    } else {
                        return message1.date! < message2.date!
                    }
                }
                self.lastMessageId = self.messageList.last?.messageId ?? ""
                var DateList: Set<String> = []
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                
                for message in self.messageList {
                    if let myDate = message.date {
                        
                        let dateValue = dateFormatter.string(from: myDate)
                        DateList.insert(dateValue)
                        
                    }
                }
                self.messageDateList = DateList

                print("getmessageçalıştııı")
                self.objectWillChange.send()
                
            }
        }
        
    }
    
    // bunu silme kalsın
    
    func deleteFromMe(messageId: String, groupName: String) {
        let db = Firestore.firestore()
        let chatGroupsRef = db.collection("ChatGroups").document(groupName)
        let messagesRef = chatGroupsRef.collection("Messages")
        
        messagesRef.document(messageId).delete { error in
            if let error = error {
                print("Hata oluştu: \(error)")
            } else {
                print("Mesaj başarıyla silindi")
            }
        }
    }
    
    
//     kullanıcı adını bulma
    
    func findUserName(messages: [ChatMessageModel], completion: @escaping (Bool) -> Void) {
        let updatedMessages = messages
        let ref = Database.database().reference().child("Users")
        let dispatchGroup = DispatchGroup()
        
        for index in 0..<updatedMessages.count {
            let message = updatedMessages[index]
            guard let userId = message.userId else {
                continue
            }
            
            dispatchGroup.enter()
            ref.child(userId).observeSingleEvent(of: .value, with: { [self] snapshot in
                if let value = snapshot.value as? [String: Any], let userName = value["userName"] as? String {
                    
                    self.userNameList[userId] = userName
                } else {
                    print("Error: Cannot parse snapshot value")
                }
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(true) // İşlem tamamlandığında completion kapanışını çağır
        }
    }
    
    
    
    // mesajın hangi gün yazıldığını hesaplayan fonksiyon
    
    func showDays(messageDates: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy" /*HH:mm:ss:SSS"*/
        let messageDate = dateFormatter.date(from: messageDates)
        let calendar = Calendar.current
        _ = [String]()
        if let messageDate = messageDate{
            if calendar.isDateInToday(messageDate) {
                
                
                return "Bugün"
            } else if calendar.isDateInYesterday(messageDate) {
                
                return "Dün"
            } else {
                let daysAgo = calendar.dateComponents([.day], from: messageDate, to: Date()).day ?? 0
                
                if daysAgo <= 7 {
                    dateFormatter.dateFormat = "EEEE"
                    
                    return dateFormatter.string(from: messageDate)
                } else {
                    dateFormatter.dateFormat = "dd.MM.yyyy"
                    
                    
                    return dateFormatter.string(from: messageDate)
                }
            }
        }
        return "Default Değer"
    }

    
    func filterMessagesByDate(liste: [ChatMessageModel]) {
        
        let myMessageList = liste.sorted(by: self.messageSortComparator(_:_:))
        guard let lastCoreDataMessageDate = myMessageList.last?.date else {
            // coreDataList boşsa ya da tarih içermiyorsa işlemi durdur
            print("işlem başarısız")
            return
        }
        
        // coreDataList'deki en son tarihten daha büyük olan mesajları al
        let filteredMessages = self.messageList.filter { message in
            guard let messageDate = message.date else {
                // Mesajın tarihi yoksa, bu mesajı filtreleme
                print("işlem yinede başarısız")
                return false
            }
            // Mesajın tarihi, en son coreDataList tarihinden daha büyükse, bu mesajı al
            return messageDate > lastCoreDataMessageDate
        }
        self.messageList = filteredMessages
    }
    
    
    
    func messageSortComparator(_ message1: ChatMessageModel, _ message2: ChatMessageModel) -> Bool {
        if message1.date! == message2.date! {
            let userId1 = message1.userId!.lowercased()
            let userId2 = message2.userId!.lowercased()
            return userId1.lexicographicallyPrecedes(userId2)
        } else {
            return message1.date! < message2.date!
        }
    }
    
    
    
    
    func getOldMessages(group: String, completion: @escaping ([ChatMessageModel]) -> Void) {
        let db = Firestore.firestore()
        let chatGroupsRef = db.collection("ChatGroups").document("Messages").collection(group)
        var tempList = [ChatMessageModel]()
        
        chatGroupsRef.order(by: "date", descending: true).limit(to: 50).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Veri çekme hatası: \(error)")
                completion([])
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("Belge bulunamadı.")
                completion([])
                return
            }
            
            for document in documents {
                let veri = document.data()
                let veriMessageId = document.documentID
                // Veri kontrolü
                guard let message = veri["message"] as? String,
                      let date = veri["date"] as? Timestamp, // Firestore'da tarih alanları genellikle Timestamp olarak saklanır
                      let userId = veri["userId"] as? String,
                      let messageId = veriMessageId as? String,
                      let userName = veri["userName"] as? String,
                      let answeredMessageInformation = veri["answeredMessageInformation"] as? Array<[String:String]>
                else {
                    // Eksik veya boş değer var, hata işleme yapılabilir
                    print("Eksik veya geçersiz değerler.")
                    completion([])
                    return
                }
                
                let model = ChatMessageModel(userName: userName, message: message, date: date.dateValue(), userId: userId, messageId: messageId, answeredMessageInformation: answeredMessageInformation)
                tempList.append(model)
            }
            var DateList: Set<String> = []
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            for message in tempList {
                if let myDate = message.date {
                    let dateValue = dateFormatter.string(from: myDate)
                    DateList.insert(dateValue)
                    
                }
            }
            self.oldMessageDateList = DateList
            self.oldMessageList = tempList
            self.oldMessageList = self.oldMessageList.sorted(by: self.messageSortComparator(_:_:))
                    completion(tempList)

           
        }
    }
    
    
    
    
    
    
    
    
    func listenForDeletedDocuments(group:String) {
        
        let chatGroupsRef = db.collection("ChatGroups").document("Messages").collection(group)
        
        chatGroupsRef.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshot: \(error!)")
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                if diff.type == .removed {
                    // Silinen belgeyle ilgili işlemleri yapabilirsiniz
                    let deletedDocument = diff.document
                    self.deletedMessages.removeAll()
                    if self.oldMessageList.contains(where: { model in
                        if model.messageId == deletedDocument.documentID {
                            return true
                        }
                        else {
                            return false
                        }
                        
                    }){
                        self.deletedMessages.removeAll()
                        self.deletedMessages.append(deletedDocument.documentID)
                    }
                    
                    print("Deleted document: \(deletedDocument.documentID)")
                    
                    // Örneğin, silinen belgeyi yerel olarak güncelleyebilirsiniz
                    // veya kullanıcı arayüzünde bir bildirim gösterebilirsiniz
                }
            }
        }
    }
    
    
    func getVeryOldMessages(group: String, QueryDate : Date, completion: @escaping ([ChatMessageModel]) -> Void){
        let startDate = QueryDate
        let chatGroupsRef = db.collection("ChatGroups").document("Messages").collection(group).whereField("date", isLessThan:  startDate ?? Date.now)
        
        var tempList = [ChatMessageModel]()
        
        chatGroupsRef.order(by: "date", descending: true).limit(to: 10).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Veri çekme hatası: \(error)")
                completion([])
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("Belge bulunamadı.")
                completion([])
                return
            }
            
            for document in documents {
                let veri = document.data()
                let veriMessageId = document.documentID
                // Veri kontrolü
                guard let message = veri["message"] as? String,
                      let date = veri["date"] as? Timestamp, // Firestore'da tarih alanları genellikle Timestamp olarak saklanır
                      let userId = veri["userId"] as? String,
                      let userName = veri["userName"] as? String,
                      let messageId = veriMessageId as? String,
                      let answeredMessageInformation = veri["answeredMessageInformation"] as? Array<[String:String]>
                else {
                    // Eksik veya boş değer var, hata işleme yapılabilir
                    print("Eksik veya geçersiz değerler.")
                    completion([])
                    return
                }
                
                let model = ChatMessageModel(userName: userName, message: message, date: date.dateValue(), userId: userId, messageId: messageId, answeredMessageInformation: answeredMessageInformation)
                tempList.append(model)
            }
            var DateList: Set<String> = []
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            for message in tempList {
                if let myDate = message.date {
                    //                    let formattedDate = dateFormatter.string(from: myDate)
                    //                    let DateInformation = self.showDays(messageDates: formattedDate)
                    //                    var  dateData = [String:Date] ()
                    //                    dateData[DateInformation] = myDate
                    let dateValue = dateFormatter.string(from: myDate)
                    DateList.insert(dateValue)
                    
                }
            }
            self.veryOldMessageDateList = DateList

            completion(tempList)

        }
        
    }
    

    
    func cleanMessageList(){
        self.messageList.removeAll()
    }
    

}
