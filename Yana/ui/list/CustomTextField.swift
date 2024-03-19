//
//  CustomTextField.swift
//  Yana
//
//  Created by serhat on 25.12.2023.
//

import SwiftUI

struct CustomTextField: View {
    var hint :String
    @Binding var tf :String
    var iconName:String
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.black).font(.headline)
            TextField(hint, text: $tf).onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
             
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black,lineWidth: 1))
        
        
        
    }
}
//#Preview {
//    CustomTextField()
//}
