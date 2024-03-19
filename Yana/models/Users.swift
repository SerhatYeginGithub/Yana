//
//  Users.swift
//  Yana
//
//  Created by serhat on 23.01.2024.
//

import Foundation

class Users: Equatable {
    var userName: String?
    var userMail: String?
    var userPassword: String?
    
    init() {
        
    }
    
    init(userName: String?, userMail: String?, userPassword: String?) {
        self.userName = userName
        self.userMail = userMail
        self.userPassword = userPassword
    }
    
    static func ==(lhs: Users, rhs: Users) -> Bool {
        return lhs.userName == rhs.userName &&
               lhs.userMail == rhs.userMail &&
               lhs.userPassword == rhs.userPassword
    }
}
