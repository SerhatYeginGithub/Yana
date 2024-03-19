//
//  GameModel.swift
//  Yana
//
//  Created by serhat on 28.12.2023.
//

import Foundation

class ItemModel:Identifiable {
    var itemId :Int?
    var itemName :String?
    var itemImage:String?
    
    init(){
        
    }
    
    init(itemId: Int?, itemName: String? , itemImage: String? ) {
        self.itemId = itemId
        self.itemName = itemName
        self.itemImage = itemImage
    }
    
}
