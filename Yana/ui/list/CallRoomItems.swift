//
//  CallRoomItems.swift
//  Yana
//
//  Created by serhat on 15.03.2024.
//

import SwiftUI

 struct CallRoomItems : View {
    var typeOfAddiction : String
    var roomName :String
    var joinedMemberCount :Int
//    let colorGreen = Color(red: 154/255, green: 225/255, blue: 154/255).opacity(0.6)
//    let colorBlue = Color(red: 174/255, green: 194/255, blue: 224/255).opacity(0.8)
//    let colorPurple = Color(red: 209/255, green: 196/255, blue: 244/255)
//    let colorIndigo = Color(UIColor(.indigo.opacity(0.4)))
//    let colorOrange = Color(red: 225/255, green: 196/255, blue: 154/255).opacity(0.58)
//    var colorList: [Color]
    var screenHeight:Double
    var screenWidth :Double
        
    init(typeOfAddiction: String,roomName:String,JoinedMemberCount :Int,screenWidth: Double,screenHeight:Double) {
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        self.typeOfAddiction = typeOfAddiction
        self.roomName = roomName
        self.joinedMemberCount = JoinedMemberCount
//            colorList = [colorGreen, colorBlue, colorPurple, colorIndigo/*, colorOrange*/]
        }
    var body: some View {
        Rectangle().foregroundColor(.clear).frame(width: screenWidth, height: screenHeight / 6).background(
                HStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: screenWidth / 4, height: screenWidth / 4)
                        .background(
                            Image(typeOfAddiction).resizable()
                        )
                    
                    VStack(alignment: .leading) {
                        Text("Oda Adı: \(roomName)").font(.italic(.headline)())
                        Text("Katılımcı Sayısı: \(joinedMemberCount)/4")
                        Button("Katıl") {
                            // Butona tıklandığında yapılacak işlemler
                           
                        }
                        .foregroundColor(.white)
                        .frame(width: screenWidth / 2, height: screenHeight / 15)
                        .background(.green)
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.black, lineWidth: 0.5)
                        )
                    }
                    .frame(maxHeight: .infinity) // Tüm boş alanı kaplaması için
                    .padding()
                    
                }
                    .padding(.horizontal,10)
                
                .background(getColor(typeOfAddiction: typeOfAddiction))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
               )
       
          
        }
}
//
//private func getTypeOfAddiction(typeOfAddiction:String)->String{
//  
//    switch typeOfAddiction {
//    case "Alışveriş Bağımlılığı":
//      return "shopping"
//    case "Alkol Bağımlılığı":
//      return "alcohol"
//    case "Cinsel Bağımlılıklar":
//      return "sex"
//    case "Kumar Bağımlılığı":
//      return "gambling"
//    case "Madde Bağımlılığı" :
//        return "drug"
//    case "Sigara Bağımlılığı":
//        return "smoking"
//    case "Teknoloji Bağımlılığı":
//        return "technology"
//    case "Yeme Bağımlılığı":
//        return "food"
//    default:
//      return "Geçersiz"
//    }
//}
//
//private func getColor(typeOfAddiction:String) -> Color {
//    switch typeOfAddiction {
//    case "shopping":
//      return Color(UIColor(.indigo.opacity(0.4)))
//    case "alcohol":
//      return Color(red: 174/255, green: 194/255, blue: 224/255).opacity(0.8)
//    case "sex":
//      return Color(UIColor(.indigo.opacity(0.4)))
//    case "gambling":
//      return Color(red: 174/255, green: 194/255, blue: 224/255).opacity(0.8)
//    case "drug" :
//        return Color(red: 174/255, green: 194/255, blue: 224/255).opacity(0.8)
//    case "smoking":
//        return Color(red: 174/255, green: 194/255, blue: 224/255).opacity(0.8)
//    case "technology":
//        return  Color(red: 209/255, green: 196/255, blue: 244/255)
//    case "food":
//        return Color(red: 174/255, green: 194/255, blue: 224/255).opacity(0.8)
//    default:
//      return Color(red: 174/255, green: 194/255, blue: 224/255).opacity(0.8)
//    }
//}

