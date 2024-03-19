//
//  ChatMessageModel.swift
//  Yana
//
//  Created by serhat on 2.02.2024.
//

import Foundation

class ChatMessageModel: Identifiable, Equatable, Hashable, Decodable{
    
    var userName: String?
    var message: String?
    var date: Date?
    var userId: String?
    var messageId: String?
    var answeredMessageInformation : [[String: String]]?

    
    init(){
        
    }
    
    init(userName: String?, message: String?, date: Date?, userId: String?, messageId: String?/*,Id : Int?*/,answeredMessageInformation : [[String: String]]?) {
        self.userName = userName
        self.message = message
        self.date = date
        self.userId = userId
        self.messageId = messageId
//        self.Id = Id
        self.answeredMessageInformation = answeredMessageInformation
    }
    
    static func == (lhs: ChatMessageModel, rhs: ChatMessageModel) -> Bool {
        return lhs.userName == rhs.userName &&
            lhs.message == rhs.message &&
            lhs.date == rhs.date &&
            lhs.userId == rhs.userId &&
            lhs.messageId == rhs.messageId &&
//            lhs.Id == rhs.Id &&
            lhs.answeredMessageInformation == rhs.answeredMessageInformation
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(userName)
        hasher.combine(message)
        hasher.combine(date)
        hasher.combine(userId)
        hasher.combine(messageId)
//        hasher.combine(Id)
        hasher.combine(answeredMessageInformation)
    
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userName = try container.decodeIfPresent(String.self, forKey: .userName)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        date = try container.decodeIfPresent(Date.self, forKey: .date)
        userId = try container.decodeIfPresent(String.self, forKey: .userId)
        messageId = try container.decodeIfPresent(String.self, forKey: .messageId)
//        Id = try container.decodeIfPresent(Int.self, forKey: .Id)
        answeredMessageInformation = try container.decodeIfPresent([[String: String]].self, forKey: .answeredMessageInformation)
    }
    
    private enum CodingKeys: String, CodingKey {
        case userName
        case message
        case date
        case userId
        case messageId
//        case Id
        case answeredMessageInformation

    }

}
