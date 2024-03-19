//
//  CreateGroupView.swift
//  Yana
//
//  Created by serhat on 31.01.2024.
//

import SwiftUI

struct CreateGroupView: View {
    @State var tf = ""
    var body: some View {
        GeometryReader {geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            VStack(){
                Text("Grup Oluştur")
                TextField("Grup Adı",text: $tf).overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.black,lineWidth: 2)).padding(screenWidth/4)
                
            }
        }
    }
}

#Preview {
    CreateGroupView()
}
