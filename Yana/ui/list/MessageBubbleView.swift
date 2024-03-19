import SwiftUI

struct MessageBubbleView: View {
    var isUser: Bool
    var message: ChatMessageModel
    var messageUser: String
    var showMessageFunctions = false
    var screenWidth :Double
    var screenHeight:Double
    var groupName : String
    @ObservedObject var viewModel : ChatMessageViewModel
    @State private var isSwiped = false
    
    var body: some View {
        VStack {
            if isUser {
                HStack {
                    //                    VStack(alignment: .leading) {
                    if let data = message.answeredMessageInformation?.first {
                        if !data.isEmpty{
                            AnsweredMessageView(selectedMessageInformation:message.answeredMessageInformation ?? [] ,screenWidth:screenWidth,screenHeight: screenHeight,message: message.message!,isUser: true, isAnsweredMessage: true)
                        }
                        else {
                            AnsweredMessageView(selectedMessageInformation:message.answeredMessageInformation ?? [] ,screenWidth:screenWidth,screenHeight: screenHeight,message: message.message!,isUser: true, isAnsweredMessage: false)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing) // Genişliği maksimuma ayarla
                
                
                
            } else {
                HStack() {
                    Text("\(messageUser)")
                        .font(.footnote).bold()
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                    
                    
                    
                        if let data = message.answeredMessageInformation?.first {
                            if !data.isEmpty{
                                AnsweredMessageView(selectedMessageInformation:message.answeredMessageInformation ?? [] ,screenWidth:screenWidth,screenHeight: screenHeight,message: message.message!,isUser: false ,isAnsweredMessage: true)
                            }
                            else {
                                AnsweredMessageView(selectedMessageInformation:message.answeredMessageInformation ?? [] ,screenWidth:screenWidth,screenHeight: screenHeight,message: message.message!,isUser: false, isAnsweredMessage: false)
                            }
                    }
                    
                }
                
//                 Genişliği maksimuma ayarla
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            
            
        }
        .padding(.horizontal, 20)
//        .multilineTextAlignment(isUser ? .leading : .trailing)
//        .frame(maxWidth: .infinity, alignment: isUser ? .leading : .leading) // Hizalamayı ayarla
        .padding(isUser ? .leading : .trailing, isUser ? screenWidth / 3 : screenWidth / 5 ) // İstenilen boşluk
        
        .offset(x: isSwiped ? screenWidth / 8 : 0) // Sağa doğru kaydırma için offset kullanılıyor
        .animation(isSwiped ? .easeOut : .easeIn) // Animasyonu ekleyebilirsiniz
                        .gesture(
                            DragGesture(minimumDistance: 10)
                                .onChanged { value in
                                    if value.translation.width > 0 {
                                        isSwiped = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            isSwiped = false
                                        }
                                    }
                                }
                                .onEnded { value in
                                    if value.translation.width > 10 {
                                        // Yana kaydırma sağa doğru yapıldı
                                        viewModel.selectedMessageInformation = [:]
                                        viewModel.selectedMessageInformation["userName"] =  viewModel.messageUserNameList[message.userId ?? "default"]  /*message.userId ?? "default"*/
                                        viewModel.selectedMessageInformation["message"] = message.message ?? "default"
                                        viewModel.isAnswerMessage = true
                                        isSwiped = false
                                    } else {
                                        isSwiped = false
                                    }
                                }
                        )
        
       
        .contextMenu {
            if isUser {
                Button(action: {
                    // Silme işlemi
                            viewModel.deleteMessage(messageId: message.messageId ?? "default", groupName: groupName)
           
                }) {
                    Label("Sil", systemImage: "trash")
                }
            }
            Button(action: {
                // Kopyalama işlemi
                UIPasteboard.general.string = message.message
            }) {
                Label("Kopyala", systemImage: "doc.on.doc")
            }
            Button(action: {
                // Cevaplama işlemi
                viewModel.isAnswerMessage = false
                viewModel.selectedMessageInformation = [:]
                viewModel.selectedMessageInformation["userName"] =  viewModel.messageUserNameList[message.userId ?? "default"]  /*message.userId ?? "default"*/
                viewModel.selectedMessageInformation["message"] = message.message ?? "default"
                viewModel.isAnswerMessage = true
            }) {
                Label("Cevapla", systemImage: "arrowshape.turn.up.left")
            }
        }
     
        
        
        
        
        
 

        
    }
  
    
}

struct AnsweredMessageView :View {
    
    var selectedMessageInformation : [[String:String]]
    var screenWidth :Double
    var screenHeight : Double
    var message: String
    var isUser :Bool
    var isAnsweredMessage :Bool
    let color1 = Color(red: 200/255, green: 162/255, blue: 200/255).opacity(0.5)// pembe
    let color2 = Color(red: 166/255, green: 196/255, blue: 224/255).opacity(0.9) // Açık Mavi
    let color3 = Color(red: 0/255, green: 119/255, blue: 190/255).opacity(0.30)
    
    var body: some View {
            VStack(alignment: isUser ? .trailing : .leading) { // Hizalama ayarını güncelledik
                if isAnsweredMessage {
                    HStack {
                        Rectangle()
                            .foregroundColor(.brown.opacity(0.8))
                            .frame(width: 10, height: 50)
                        VStack(alignment: .leading) {
                            Text("\(selectedMessageInformation.first?["userName"] ?? "default")")
                                .font(.footnote)
                                .bold()
                            Text(selectedMessageInformation.first?["message"] ?? "Default")
                                .font(.footnote)
                        }
                        .padding()
                        .frame(maxWidth: 300, maxHeight: 50)
                    }
                    .background(isUser ? color2 : color1)
                    .cornerRadius(10)
                }
                
                Text(message)
                    .lineLimit(nil)
            }
            .padding()
            .background(isUser ? color1 : color3)
            .cornerRadius(25)
        }
}

