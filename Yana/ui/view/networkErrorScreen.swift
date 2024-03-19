//
//  networkErrorScreen.swift
//  Yana
//
//  Created by serhat on 30.01.2024.
//

import SwiftUI

struct networkErrorScreen: View {
    var body: some View {
        HStack{
            Image(systemName: "wifi.slash").font(.largeTitle).foregroundColor(.red)
            Text("İnternet Bağlantısı Yok").font(.title2).bold()
        }
    }
}

#Preview {
    networkErrorScreen()
}
