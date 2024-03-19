import FirebaseFunctions

// Firestore trigger
enum TriggerType: String, Codable {
    case onCreate
    case onUpdate
    case onDelete
}

// Firestore event
struct FirestoreEvent: Codable {
    let data: [String: Any]
    let eventId: String
    let timestamp: String
    let triggerType: TriggerType
}

// Firestore trigger function
exports.firestoreTrigger = functions.region("your-region").firestore
    .document("your-collection/{documentId}")
    .onDelete { (snapshot, context) in
        let deletedData = snapshot.data()
        print("Silinen veri:", deletedData)
        // Silinen veriyi kullanarak istediğiniz işlemleri gerçekleştirin
        // Örneğin, bir bildirim gönderebilirsiniz
        return nil
    }
