//
//  XOXgamePage.swift
//  Yana
//
//  Created by serhat on 4.01.2024.
//

import SwiftUI

struct XOXgamePage: View {
    @State private var XOXList = [XOXGameModel]()
    @State private var yourTurn = true
    var body: some View {
        ZStack {
            Color(red: 200/255, green: 162/255, blue: 200/255).opacity(0.4)
                .ignoresSafeArea()
            GeometryReader {geometry in
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height
                VStack {
                    Spacer()
                    VStack(spacing:screenHeight/10) {
                        Text("SENİN SIRAN")
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10){
                            ForEach(XOXList){game in
                                gridItem(itemSize: screenHeight/10,xo: game.name!).onTapGesture {
                                    if yourTurn{
                                        if game.name == ""{
                                            XOXList[game.id!-1].name = "X"
                                        }
                                    }
                                }
                                
                            }
                        }
                        
                    }.padding(.horizontal,screenWidth/8)
                    Spacer()
                    Spacer()
                }
                .onAppear(){
                    var list = [XOXGameModel]()
                    var number = 1
                    while(true){
                        let l = XOXGameModel(id: number, name: "")
                        list.append(l)
                        number = number + 1
                        if number == 10{
                            break
                        }
                    }
                    XOXList = list
                }
            }
        }
    }
    struct gridItem:View {
        let itemColor = Color(red: 174/255, green: 217/255, blue: 224/255)
        let itemSize:Double
       @State  var xo = ""
        var body: some View {
            ZStack{
                Rectangle()
                    .frame(width: itemSize,height: itemSize)
                    .foregroundColor(.indigo)
                    .border(Color.black)
                Text(xo).font(.title).foregroundColor(.white)
            }
        }
    }
}

#Preview {
    XOXgamePage()
}
