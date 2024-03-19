//
//  XOXGameModel.swift
//  Yana
//
//  Created by serhat on 4.01.2024.
//

import Foundation

class XOXGameModel:Identifiable{
    var id:Int?
    var name:String?
    
    init( id:Int?,name:String?) {
        self.id = id
        self.name = name
    }
}
