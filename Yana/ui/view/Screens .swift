//
//  Screens .swift
//  Yana
//
//  Created by serhat on 22.01.2024.
//

import SwiftUI

struct Screens: View {
    @State private var showRegisterScreen = false
    var body: some View {
        if showRegisterScreen {
            RegisterScreen()
        }
        
    }
}

#Preview {
    Screens()
}
