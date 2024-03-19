import SwiftUI
struct CustomItemCrisis: View {
    var imageName: String
    var itemWidth: Double
    var itemHeight: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 224/255, green: 255/255, blue: 255/255).opacity(0.6))
                .frame(width: itemHeight, height: itemHeight)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: itemHeight/1.5, height: itemHeight/1.5)
        }
    }
}
