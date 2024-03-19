//
//  denemedfd.swift
//  Yana
//
//  Created by serhat on 11.02.2024.
//

import SwiftUI

struct denemedfd: View {
    var body: some View {
  
        GeometryReader {geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry .size.height
            VStack{
                VStack{
                 Spacer()
                    Text("Kopyala").bold()
                    Divider()
                    Spacer()
                    Text("Sil").foregroundColor(.red).bold().multilineTextAlignment(.leading)
                    Divider()
                    Spacer()
                    Text("Düzenle").bold()
                    Divider()
                    Spacer()
                    Text("Cevapla").foregroundColor(.blue).bold()
                    Spacer()
                  
                }  .background(.thickMaterial).frame(width: screenWidth/5,height: screenHeight/4).border(.gray).cornerRadius(25).padding(.vertical,20)
                  
                    
            }.padding()
        }
     
    }
}

#Preview {
    denemedfd()
}
