import SwiftUI

struct ChatTextField: View {
    @Binding var newMessage: String
    @ObservedObject var viewModel: AppViewModel
    @ObservedObject var vm : MessageManager
    var groupName: String
    
    func currentFormattedDateTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let currentDateTimeString = dateFormatter.string(from: Date())
        
        if let formattedDate = dateFormatter.date(from: currentDateTimeString) {
            return formattedDate
        } else {
            return Date()
        }
    }
    
    var body: some View {
        VStack{
            if vm.isAnswerMessage{
                let userName = vm.selectedMessageInformation["userName"] ?? "default kullanıcı"
                let userMessage = vm.selectedMessageInformation["message"] ?? "default Message"
//                selectedMessageView(userName: userName, message: userMessage)
                selectedMessageView(userName: userName, message: userMessage, isAnsweredMessage: $vm.isAnswerMessage)
              

            }
            HStack {
                
                TextField("Send a message", text: $newMessage)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea(.keyboard)
                Button(action: {
                    if !newMessage.isEmpty {
                        vm.sendMessage(yourMessage: newMessage, groupName: groupName,messageDate: currentFormattedDateTime(), userName: UserDefaultsManager.shared.userName!)
                        vm.isAnswerMessage = false
                        newMessage = ""
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.title)
                        .foregroundColor(!newMessage.isEmpty ? .blue : .gray)
                        .padding(.trailing)
                }
            }
            .padding(.bottom)
            .padding(.leading)
        }
    }
    }


private struct SelectedMessageView: View {

    var message: String
    var userName: String
    let color2 = Color(red: 166/255, green: 196/255, blue: 224/255).opacity(0.9)
    @Binding var isAnsweredMessage: Bool
    
    var body: some View {
        HStack {
            Rectangle()
                .foregroundColor(.brown.opacity(0.8))
                .frame(width: 10, height: 50)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(userName)
                        .font(.footnote)
                        .bold()
                    
                    Spacer()
                    
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.black)
                        .onTapGesture {
                            isAnsweredMessage = false
                        }
                }
                
                Text(message)
                    .font(.footnote)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 50)
        }
        .background(color2)
        .cornerRadius(10)
    }
}


private struct selectedMessageView: View {
    var userName :String
    var message:String
    @Binding var isAnsweredMessage: Bool
    var body: some View {
        HStack(){
            Rectangle()
                .foregroundColor(.black)
                .frame(width: 10,height: 50)
               
            VStack(alignment:.leading){

                HStack {
                    Text(userName).font(.subheadline).bold()
                    Spacer()
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.black) .font(.subheadline)
                        .onTapGesture {
                            isAnsweredMessage = false
                        }
                    
                    
                }
   
                Text(message) .font(.subheadline).lineLimit(1)

            }
         Spacer()
        }.frame(maxWidth: .infinity).background(Color(.systemGray4)).cornerRadius(10).padding(.horizontal)
            
    }
}

//#Preview(body: {
//    selectedMessageView(userName: "userName", message: "userMessage")
//})
