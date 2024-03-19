////
////  CreateChatGroup.swift
////  Yana
////
////  Created by serhat on 10.03.2024.
////
//
//import SwiftUI
//
// struct createGroupView :View {
//     @ObservedObject var vm : ChatViewModel
//    @State private var tf = ""
//    @State private var selectedOption = 0
//    @Binding var showAlert : Bool
//    private let options = ["Alkol Bağımlılığı", "Sigara Bağımlılığı", "Madde Bağımlılığı","Kumar Bağımlılığı","Teknoloji Bağımlılığı","Cinsel Bağımlılıklar","Alışveriş Bağımlılığı","Yeme Bağımlılığı"]
//    var body: some View {
//        VStack(alignment: .leading,spacing: 20){
//  
//            Text("Grup Oluştur").font(.title).bold()
//            TextField("Grup Adı: ", text: $tf)
//       .cornerRadius(8)/*.border(Color.black)*/
//       .textFieldStyle(.roundedBorder)
//                .ignoresSafeArea(.keyboard)
//            Picker("Bağımlılık", selection: $selectedOption) {
//                ForEach(0..<options.count) { index in
//                        Text(options[index])
//                   }
//                }
//            .pickerStyle(.automatic)
//            
//            HStack{
//                Spacer()
//                Button("Vazgeç",action: {showAlert = false}).font(.title3).foregroundColor(.red).padding().background(Color(.systemGray3).opacity(0.5)).cornerRadius(20)
//                Spacer()
//                Button("Oluştur",action: {}).font(.title3).foregroundColor(.blue).padding().background(Color(.systemGray3).opacity(0.5)).cornerRadius(20)
//                Spacer()
//            }
//            
//        }.padding().background(Color(.systemGray5)).padding().overlay( /// apply a rounded border
//            RoundedRectangle(cornerRadius: 20)
//                .stroke(.black, lineWidth: 2)
//                .padding()
//        )
//    }
//     
//     
//    
//     
//     
//     
//     
//}
//
////#Preview {
////    createGroupView()
////}
