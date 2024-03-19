import SwiftUI
import Combine

struct ChatDetailScreen: View {
  @State private var newMessage: String = ""
  @State var groupName: String
  @State var showAlert = false
  @State private var userNameList = [String: String]()
  @ObservedObject var appViewModel: AppViewModel
  @State private var selectedMessageId: String = ""
  @State var messages = [ChatMessageModel]()
  @State var newMessages = [ChatMessageModel]()
  @State private var dateList: Array<[String:String]> = []
  @ObservedObject var vm : MessageManager
  @State private var veryOldMessages = [ChatMessageModel]()
  @State private var messagesDateList : Set<String> = []
  @State private var newMessagesDateList : Set<String> = []
  @State private var veryOldMessagesDateList : Set<String> = []
    
    
  init(groupName: String, appViewModel: AppViewModel, vm: MessageManager) {
    self.groupName = groupName
    self.appViewModel = appViewModel
    self.vm = vm
    vm.getMessage(group: groupName)
    vm.listenForDeletedDocuments(group: groupName)
  }
 
    
  var body: some View {
    NavigationView {
      VStack {
        ScrollViewReader{ scrollViewProxy in
          ScrollView {
            Button {
              let tempMessage = messages.sorted(by: messageSortComparator(_:_:))
              let sortedVeryOldList = veryOldMessages.sorted(by: messageSortComparator(_:_:))
              guard let tempDate = (tempMessage.first?.date) else {return }
              let startDate = veryOldMessages.isEmpty ? (tempMessage.first?.date)! : (sortedVeryOldList.first?.date)!
              vm.getVeryOldMessages(group: groupName, QueryDate: startDate) { result in
                if !result.isEmpty{
                  let oldList = result.sorted(by: messageSortComparator(_:_:))
                  let currentDate = Date()
                  let futureDate = calculate24HoursLaterDate(from: (oldList.last?.date)!)
                   
                  if currentDate < futureDate {
                    let filteredList = oldList.filter { message in
                      let messageDate = calculate24HoursLaterDate(from: message.date!)
                      return currentDate <= messageDate
                    }
                    messages.append(contentsOf: filteredList)
                    for d in vm.oldMessageDateList{
                      messagesDateList.insert(d)
                    }
                     
                     
                    let remainingList = oldList.filter { message in
                      let messageDate = calculate24HoursLaterDate(from: message.date!)
                      return currentDate > messageDate
                    }
                    veryOldMessages.append(contentsOf: remainingList)
   
                    for d in vm.veryOldMessageDateList{
                      veryOldMessagesDateList.insert(d)
                    }
                  }
                  else {
                    veryOldMessages.append(contentsOf: oldList)

                    for d in vm.veryOldMessageDateList{
                      veryOldMessagesDateList.insert(d)
                    }
                    print("Bu blok çalıştı")
                  }
                }
              }
               
            } label: {
              Text("Eski Mesajları Yükle")
            }
            Text("**********************")
            MessageListView(list: veryOldMessages , vm: vm, groupName: groupName,dateList: veryOldMessagesDateList,lastDate: "")
            Divider()
            MessageListView(list: messages,  vm: vm, groupName: groupName, dateList: messagesDateList, lastDate: Array(veryOldMessagesDateList).sorted(by: dateSortComparator).last ?? "10/12/2001")
            Divider()
            MessageListView(list: newMessages, vm: vm, groupName: groupName, dateList: newMessagesDateList, lastDate: Array(messagesDateList).sorted(by: dateSortComparator).last ?? "10/12/2001")
          }
          .onAppear(){
            appViewModel.tabbarVisibility = .yes
            messages = vm.oldMessageList
            newMessages = vm.messageList
            messagesDateList = vm.oldMessageDateList
            newMessagesDateList = vm.messageDateList
              
          }
        }
         
        Spacer()
        ChatTextField(newMessage: $newMessage, viewModel: appViewModel, vm: vm, groupName: groupName)
      }
      .navigationBarItems(
        leading:
          HStack {
            Image(systemName: "arrow.left")
              .onTapGesture {
                appViewModel.tabbarVisibility = .no
                appViewModel.currentScreen = .tabbar
              }
            Spacer()
            Text(updateGroupName(groupName: groupName)).bold()
          }
      )
      .navigationBarItems(
        trailing:
          Rectangle()
          .frame(width: 40, height: 40)
          .foregroundColor(.clear)
          .background(Image(groupName).resizable())
      )
    }
    .onChange(of: vm.messageList) { newValue in
//        let newMessagesToAdd = newValue.filter { !newMessages.contains($0) }
//        newMessages.append(contentsOf: newMessagesToAdd)
        
        newMessages = vm.messageList
        
        // newMessagesDateList'i güncelle
        if newMessagesDateList.count < vm.messageDateList.count {
            newMessagesDateList = vm.messageDateList
        }
    }

      
    .onChange(of: vm.deletedMessages) { newValue in
      guard let messageIdToDelete = newValue.first else { return }
      messages.removeAll { $0.messageId == messageIdToDelete }
    }
      


    .onDisappear {
      appViewModel.tabbarVisibility = .no
    }
     
  }
   
   
}
   
private struct MessageListView: View {
  var list: [ChatMessageModel]
//  var userList: [String: String]
  var vm: MessageManager
  var groupName: String
  var dateList: Set<String>
  var lastDate: String
   
  var body: some View {
    VStack {
      ForEach(Array(dateList).sorted(by: dateSortComparator), id: \.self) { mDate in
        MessageDateSectionView(
          messageDate: lastDate,
          mDate: mDate,
          list: list,
//          userList: userList,
          vm: vm,
          groupName: groupName
        )
      }
    }
  }
}

private struct MessageDateSectionView: View {
  var messageDate: String
  var mDate: String
  var list: [ChatMessageModel]
//  var userList: [String: String]
  var vm: MessageManager
  var groupName: String
   
  var body: some View {
    if convertDate(myDate: messageDate) == convertDate(myDate: mDate) {
      Group {
        MessageSectionView(
          mDate: mDate,
          list: list,
//          userList: userList,
          vm: vm,
          groupName: groupName
        )
      }
    } else {
      Section(header: customSectionView(messageDate: mDate)) {
        MessageSectionView(
          mDate: mDate,
          list: list,
//          userList: userList,
          vm: vm,
          groupName: groupName
        )
      }
    }
  }
}

private struct MessageSectionView: View {
  var mDate: String
  var list: [ChatMessageModel]
//  var userList: [String: String]
  var vm: MessageManager
  var groupName: String
   
  var body: some View {
    ForEach(list.sorted(by: messageSortComparator)) { message in
      if FormattedDateTime(messageDate: message.date!) == convertDate(myDate: mDate) {
          let messageUserName = message.userName ?? "default kullanıcı"
        if message.userId == UserDefaultsManager.shared.userId {
          messageBubbleView(message: message, vm: vm, groupName: groupName)
        } else {
          messageBubbleViewUser(message: message, vm: vm, groupName: groupName, messageUserName: messageUserName)
        }
      }
    }
  }
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





func updateGroupName(groupName: String) -> String {
  switch groupName {
  case "alcohol":
    return "Alkol Bağımlılığı ile Mücadele"
  case "smoking":
    return "Sigara Bağımlılığı ile Mücadele"
  case "drug":
    return "Madde Bağımlılığı ile Mücadele"
  case "gambling":
    return "Kumar Bağımlılığı ile Mücadele"
  case "sex" :
      return "Cinsel Bağımlılık ile Mücadele"
  case "food":
      return "Yeme Bağımlığı ile Mücadele"
  case "technology":
      return "Teknoloji Bağımlılığı ile Mücadele"
  case "shopping":
      return "Alışveriş Bağımlılığı ile Mücadele"
  default:
    return "Geçersiz"
  }
}



func calculate24HoursLaterDate(from date: Date) -> Date {
  let calendar = Calendar.current
  let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
  let futureDate = calendar.date(byAdding: .hour, value: 24, to: calendar.date(from: dateComponents)!)
  return futureDate ?? Date()
}




func calculate24HoursBeforeDate(from date: Date) -> Date {
  let calendar = Calendar.current
  let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
  let pastDate = calendar.date(byAdding: .hour, value: -24, to: calendar.date(from: dateComponents)!)
  return pastDate ?? Date()
}



let dateSortComparator: (String, String) -> Bool = { (date1, date2) in
  let formatter = DateFormatter()
  formatter.dateFormat = "dd/MM/yyyy"
  if let d1 = formatter.date(from: date1), let d2 = formatter.date(from: date2) {
    return d1 < d2
  }
  return false
}


func convertDate(myDate:String) -> Date{
  let formatter = DateFormatter()
  formatter.dateFormat = "dd/MM/yyyy"
  let mDate = formatter.date(from: myDate)
  return mDate ?? Date()
}

private func FormattedDateTime(messageDate :Date) -> Date {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "dd/MM/yyyy"
  let DateTimeString = dateFormatter.string(from: messageDate)
   
   let formattedDate = dateFormatter.date(from: DateTimeString)
   
    return formattedDate!
}




private struct messageBubbleView : View {
  var message : ChatMessageModel
  @ObservedObject var vm : MessageManager
  var groupName : String
  var body: some View {
      Group{
          if let answeredMessage = message.answeredMessageInformation?.first{
              if !(answeredMessage.isEmpty){
                  
                  answeredMessageView(userName: answeredMessage["userName"] ?? "default" , userMessage: answeredMessage["message"] ?? "defaultMessage", message: message.message ?? "default Message")
                  
              }
              else {
                  HStack {
                      Spacer()
                      
                      Text(message.message ?? "default")
                          .foregroundColor(.white)
                          .padding()
                      
                          .background(Color.blue)
                          .cornerRadius(12)
                  }
                  .padding(.horizontal)
                  .padding(.top, 8)
              }
          }
       
      }
    .contextMenu(ContextMenu(menuItems: {
      Button{
        let currentDate = Date()
        let futureDate = calculate24HoursLaterDate(from: message.date!)
         
        if currentDate <= futureDate {
          vm.deleteMessage(messageId: message.messageId ?? "default", groupName: groupName)
        }
        else {
          print("Mesaj silinemez üzerinden 24 saat geçtiğği için")
          print(message.date!)
        }
      }label: {
        Label("Sil", systemImage: "trash.fill").foregroundColor(.red)
         
      }
      Button{
        UIPasteboard.general.string = message.message ?? "default"
      }label: {
        Label("Kopyala", systemImage: "doc.on.doc")
         
         
      }
      Button{
        vm.selectedMessageInformation.removeAll()
        vm.selectedMessageInformation["message"] = message.message ?? "default"
          vm.selectedMessageInformation["userName"] = message.userName ?? "Kullanıcı Bulunamadı"
        vm.isAnswerMessage = true
         
      }label:{
        Label("Cevapla", systemImage: "arrow.turn.down.left")
         
      }
    }))
  }
}


private struct messageBubbleViewUser : View {
  var message : ChatMessageModel
  @ObservedObject var vm : MessageManager
  var groupName : String
  var messageUserName :String
  let backgroundColor = Color(red: 0/255, green: 100/255, blue: 0/255).opacity(0.7)
  var body: some View {
      Group{
          
          if let answeredMessage = message.answeredMessageInformation?.first{
              if !(answeredMessage.isEmpty){
                  
                  answeredMessageViewUser(messageUserName: message.userName ?? "", userName: answeredMessage["userName"] ?? "default" , userMessage: answeredMessage["message"] ?? "defaultMessage", message: message.message ?? "default Message")
                  
              }
              else {
                  
                  HStack {
                      VStack(alignment: .leading) {
                          
                          Text(messageUserName).font(.headline).bold().foregroundColor(.white)
                          Divider().frame(width: 100).background(.white).frame(width: .infinity)
                    
                          Text(message.message ?? "default").foregroundColor(.white)
                          
                      }
                      .padding()
                      .background(backgroundColor)
                      .cornerRadius(12)
                      Spacer()
                  }
                  .padding(.horizontal)
                  .padding(.top, 8)
              }
          }
      }
      .contextMenu(ContextMenu(menuItems: {
        Button{
          UIPasteboard.general.string = message.message ?? "default"
        }label: {
          Label("Kopyala", systemImage: "doc.on.doc")
           
        }
        Button{
          vm.selectedMessageInformation.removeAll()
          vm.selectedMessageInformation["message"] = message.message ?? "default"
          vm.selectedMessageInformation["userName"] = messageUserName
          vm.isAnswerMessage = true
           
        }label: {
          Label("Cevapla", systemImage: "arrow.turn.down.left")
           
        }
      }))
    
  }
}



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




private struct customSectionView : View {

  var messageDate : String
  let backgroundColor = Color(red: 0/255, green: 100/255, blue: 0/255).opacity(0.7)
  var body: some View {
    Text(showDays(messageDates:messageDate)).font(.footnote).foregroundColor(.white) .padding().background(.gray).cornerRadius(100)
      
  }
}



private struct answeredMessageView: View {

    var userName: String
    var userMessage: String
    var message : String
    let color2 = Color(red: 166/255, green: 196/255, blue: 224/255).opacity(0.9)
    let backgroundColor = Color(red: 0/255, green: 100/255, blue: 0/255).opacity(0.7)
    var body: some View {
        
        
        HStack {
          Spacer()
            VStack(alignment: .leading){
                HStack {
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(width: 10, height: 50)

                    VStack(alignment: .leading) { // alignment parametresi kullanıldı
                        Text(userName)
                            .font(.subheadline)
                            .bold()
                        Text(userMessage)
                            .lineLimit(1)
                            .font(.subheadline)
                    }
                    Spacer()
                }
                .background(Color(.systemGray4))
                .cornerRadius(10)
                
            
 
                Text(message)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.vertical,4)
             
            }.background(Color.blue)
                .cornerRadius(12)
        }
        .padding(.trailing,15)
        .padding(.leading,150)
        .padding(.top, 8)
        
        
     
    }
}



private struct answeredMessageViewUser :View {
    var messageUserName :String
    var userName: String
    var userMessage: String
    let backgroundColor = Color(red: 0/255, green: 100/255, blue: 0/255).opacity(0.7)
    var message : String
    var body: some View {
        HStack {
          VStack(alignment: .leading) {
           
            Text(messageUserName)
                  .font(.headline).bold().foregroundColor(.white)
              Divider().frame(width: 100).background(.white).frame(width: .infinity)
              HStack {
                  Rectangle()
                      .foregroundColor(.black)
                      .frame(width: 10, height: 50)

                  VStack(alignment: .leading) { // alignment parametresi kullanıldı
                      Text(userName)
                          .font(.subheadline)
                          .bold()
                      Text(userMessage)
                          .lineLimit(1)
                          .font(.subheadline)
                  }
                  Spacer()
              }
              .background(Color(.systemGray4))
              .cornerRadius(5)
             
              
                  
                  Text(message).foregroundColor(.white)
   
          }
          
          .padding(.vertical)
          .padding(.trailing)
          .padding(.leading,10)
          
          .background(backgroundColor)
          .cornerRadius(12)
          Spacer()
        }
        .padding(.leading,15)
        .padding(.trailing,150)
        .padding(.top, 8)
        
    }
}

//#Preview(body: {
//    answeredMessageViewUser(messageUserName: "serhat", userName: "mehtap", userMessage: "bu bir deneme mesajıdır", message: "bencede bu bir denemedir jkdfhdj kbvdd kdbvd b sdvjs.")
//})
