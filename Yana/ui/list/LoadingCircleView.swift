//
//  loadinCircleView.swift
//  Yana
//
//  Created by serhat on 1.02.2024.
//

import SwiftUI


struct LoadingCircleView: View {
    @State private var isAnimating = true
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color.gray, lineWidth: 5)
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                .onAppear {
                    isAnimating = true
                    
                }
                .onDisappear {
                    isAnimating = false
                }
        }
    }
}

#Preview {
    LoadingCircleView()
}
