//
//  CrisisScreen.swift
//  Yana
//
//  Created by serhat on 29.12.2023.
//

import SwiftUI

struct CrisisScreen: View {
    var body: some View {
        GeometryReader{geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            if screenHeight <= 667.0{
                          SmallCrisisScreen()
                      } else if screenHeight > 667.0 && screenHeight <= 932.0 {
                          MediumCrisisScreen()
                      } else {
                          LargeCrisisScreen()
                      }
        }
    }
}

#Preview {
    CrisisScreen()
}
