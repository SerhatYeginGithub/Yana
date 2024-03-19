//
//  UserDefaultManager.swift
//  Yana
//
//  Created by serhat on 21.01.2024.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let userDefaults = UserDefaults.standard
    
    private let emailKey = "email"
    private let passwordKey = "password"
    private let userNameKey = "userNameKey"
    private let userIdKey = "userIdKey"
    
    var email: String? {
        get { return userDefaults.string(forKey: emailKey) }
        set { userDefaults.set(newValue, forKey: emailKey) }
    }
    
    var password: String? {
        get { return userDefaults.string(forKey: passwordKey) }
        set { userDefaults.set(newValue, forKey: passwordKey) }
    }
    var userName:String? {
        get{return userDefaults.string(forKey: userNameKey)}
        set { userDefaults.set(newValue, forKey: userNameKey) }
    }
    var userId:String? {
        get { return userDefaults.string(forKey: userIdKey) }
        set { userDefaults.set(newValue, forKey: userIdKey) }
    }
    
    private init(){
        
    }
    
    func clearUserData() {
        userDefaults.removeObject(forKey: emailKey)
        userDefaults.removeObject(forKey: passwordKey)
        userDefaults.removeObject(forKey: userNameKey)
        userDefaults.removeObject(forKey: userIdKey)
    }
}
