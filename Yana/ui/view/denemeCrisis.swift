//import SwiftUI
//
//
//struct deneme: View {
//    var liste :[ChatMessageModel] =  [ChatMessageModel(userName: "user1", message: "mesaj1", date: "04.02.2024 15:57:14:319", userId: "fYakYipwDOgLMGGIg2Il80LaSVT2"),ChatMessageModel(userName: "user2", message: "mesaj2", date: "04.02.2024 15:57:14:319", userId: "faakYipwDOgLMGGIg2Il80LaSVT1"),ChatMessageModel(userName: "user3", message: "mesaj3", date: "04.02.2024 15:57:14:319", userId: "fYakYipwDOgLMGGIg2Il80LaSVT0")]
//
//     func sortla()-> [ChatMessageModel]{
//        var mylist = liste.sorted(by: { (message1, message2) in
//            if message1.date! == message2.date! {
//                let userId1 = message1.userId!.lowercased()
//                let userId2 = message2.userId!.lowercased()
//                
//                // UserId'leri tek tek karakterleriyle karşılaştır
//                return userId1.lexicographicallyPrecedes(userId2)
//            } else {
//                return message1.date! < message2.date!
//            }
//        })
//         return mylist
//         
//    }
//    
//    var body: some View {
//        
//        
//        VStack {
//            ForEach(sortla()){m in
//                
//                HStack {
//                    Text(m.userId!)
//                    Text(m.message!)
//                }
//                
//            }
//        }.onAppear(){
//            sortla()
//        }
//    }
//}
//
//
//#Preview {
//    deneme()
//}
