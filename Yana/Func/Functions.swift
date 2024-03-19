//
//  Functions.swift
//  Yana
//
//  Created by serhat on 15.03.2024.
//

import Foundation
import SwiftUI

 func getTypeOfAddiction(typeOfAddiction:String)->String{
  
    switch typeOfAddiction {
    case "Alışveriş Bağımlılığı":
      return "shopping"
    case "Alkol Bağımlılığı":
      return "alcohol"
    case "Cinsel Bağımlılıklar":
      return "sex"
    case "Kumar Bağımlılığı":
      return "gambling"
    case "Madde Bağımlılığı" :
        return "drug"
    case "Sigara Bağımlılığı":
        return "smoking"
    case "Teknoloji Bağımlılığı":
        return "technology"
    case "Yeme Bağımlılığı":
        return "food"
    default:
      return "Geçersiz"
    }
}

func getColor(typeOfAddiction:String) -> Color {
    switch typeOfAddiction {
    case "shopping":
      return Color(UIColor(.indigo.opacity(0.4)))
    case "alcohol":
      return Color(red: 174/255, green: 194/255, blue: 224/255).opacity(0.8)
    case "sex":
      return Color(UIColor(.indigo.opacity(0.4)))
    case "gambling":
      return Color(red: 174/255, green: 194/255, blue: 224/255).opacity(0.8)
    case "drug" :
        return Color(red: 174/255, green: 194/255, blue: 224/255).opacity(0.8)
    case "smoking":
        return Color(red: 174/255, green: 194/255, blue: 224/255).opacity(0.8)
    case "technology":
        return  Color(red: 209/255, green: 196/255, blue: 244/255)
    case "food":
        return Color(red: 174/255, green: 194/255, blue: 224/255).opacity(0.8)
    default:
      return Color(red: 174/255, green: 194/255, blue: 224/255).opacity(0.8)
    }
}

