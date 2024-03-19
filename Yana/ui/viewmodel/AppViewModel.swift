//
//  AppViewModel.swift
//  Yana
//
//  Created by serhat on 23.01.2024.
//

import Foundation
import Network
import SwiftUI

class AppViewModel: ObservableObject {
    @Published var callDetailList = [String:Any]()
    @Published var currentScreen: Screens = .splash
    @Published var isInternet = false
    @Published var isInternetAvailable = false
    @Published var showGroup:ChatGroupNames = .none
    @Published var ChatDetailPageList = [String: Any]()
    @Published var tabbarSelectedPage  = 0
    @Published var tabbarItems : tab = .house
    @Published var tabbarVisibility : tabVisibility = .no
    @ObservedObject var messageViewModel = MessageManager()
    @Published var tabItemColors :[String:Any] = ["home":Color.black,"chat": Color.black,"crisis": Color.black,"call":Color.black,"setting":Color.black]
    @Published var messageDate = ""
   
    
    
    private var monitor: NWPathMonitor?
    
    
    
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss:SSS"
        return dateFormatter.string(from: Date())
    }

    func updateGroupName(groupName: String) -> String {
        switch groupName {
        case "alcohol":
            return "Alkol Bağımlılığı ile Mücadele"
        case "smoking":
            return "Sigara Bağımlılığı ile Mücadele"
        case "drug":
            return "Madde Bağımlılığı ile Mücadele"
        case "gambling":
            return "Kumar Bağımlılığı ile Mücadele"
        default:
            return "Geçersiz"
        }
    }
    
    func startMonitoringInternetConnection() {
        
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetMonitor")
        
        monitor?.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self?.isInternet = true // İnternet bağlantısı var
                } else {
                    self?.isInternet = false // İnternet bağlantısı yok
                }
                
                self?.isInternetAvailable = self?.isInternet ?? false
            }
        }
        
        monitor?.start(queue: queue)
    }
    
    deinit {
        monitor?.cancel()
    }
    
    
    
    func showDays(messageDates: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss:SSS"
        let messageDate = dateFormatter.date(from: messageDates)
        let calendar = Calendar.current
        var day = "" // Yerel değişken olarak tanımlanır
        
        if calendar.isDateInToday(messageDate!) {
            day = "Bugün"
        } else if calendar.isDateInYesterday(messageDate!) {
            day = "Dün"
        } else {
            let daysAgo = calendar.dateComponents([.day], from: messageDate!, to: Date()).day ?? 0
            
            if daysAgo <= 7 {
                dateFormatter.dateFormat = "EEEE"
                day = dateFormatter.string(from: messageDate!)
            } else {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                day = dateFormatter.string(from: messageDate!)
            }
        }
        
        DispatchQueue.main.async {
            self.messageDate = day
        }
        
        return self.messageDate
    }
    
}

