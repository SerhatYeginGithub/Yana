import SwiftUI

struct ChatGroupView: View {
    @State var groupName: String
    @State var groupIcon : String
    @State var size:Double
    var show:Bool
    
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

    
    
    var body: some View {
        if show{
            
            HStack {
                Image(groupIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: size, height: size)
                                    .scaledToFit()
                VStack(alignment: .leading) {
                    Text(updateGroupName(groupName:groupName))
                        .font(.title3)
                        .bold()
              
    
                }
                
            }.padding()
            
        }
        else{
            HStack {
                Image(groupIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: size, height: size)
                                    .scaledToFit()
                VStack(alignment: .leading) {
                    Text(updateGroupName(groupName:groupName))
                        .font(.title2)
                        .bold()
                    Text("Grup Üyesisiniz.")
                            .font(.title3)
                    
    
                }
                
            }.padding().opacity(0.7)
        }
            
      
        
           
        }

}

//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}
