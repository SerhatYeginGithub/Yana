//
//  EmptyView.swift
//  Yana
//
//  Created by serhat on 7.02.2024.
//

import SwiftUI

struct EmptyView: View {
   
    
    var body: some View {
        VStack {
            ScrollView{
                ScrollViewReader{proxy in
                    ForEach(0..<10){i in
                        Text("\(i)")
                        
                    }
                }
            }
        }
    }
}

#Preview {
    EmptyView()
}
