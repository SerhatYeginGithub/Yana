//
//  CallModel.swift
//  Yana
//
//  Created by serhat on 15.03.2024.
//


import Foundation

class CallModel: Identifiable, Equatable, Hashable, Decodable{
  
    var director: String?
    var date: Date?
    var roomName: String?
    var roomId: String?
    var members : [String: String]?

    
    init(){
        
    }
    
    init(director: String?, roomName: String?, date: Date?,  roomId: String?,  members : [String: String]?) {
        self.director = director
        self.date = date
        self.roomName = roomName
        self.roomId = roomId
        self.members = members
    }
    
    static func == (lhs: CallModel, rhs: CallModel) -> Bool {
        return lhs.director == rhs.director &&
            lhs.roomName == rhs.roomName &&
            lhs.date == rhs.date &&
            lhs.roomId == rhs.roomId &&
            lhs.members == rhs.members
    }
    
    func hash(into hasher: inout Hasher) {
        
        hasher.combine(director)
        hasher.combine(roomId)
        hasher.combine(roomName)
        hasher.combine(date)
        hasher.combine(members)
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        director = try container.decodeIfPresent(String.self, forKey: .director)
        roomId = try container.decodeIfPresent(String.self, forKey: .roomId)
        date = try container.decodeIfPresent(Date.self, forKey: .date)
        roomName = try container.decodeIfPresent(String.self, forKey: .roomName)
        members = try container.decodeIfPresent([String: String].self, forKey: .members)
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case director
        case roomName
        case date
        case roomId
        case members

    }

}
