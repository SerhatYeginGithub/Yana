import Foundation

class ChatGroupModel: Identifiable, Equatable, Hashable, Decodable {
    var groupName: String?
    var groupDate: String?
    var isMember:Bool?
    var memberName: String?
    init(groupName: String?, groupDate: String?,isMember:Bool?,memberName: String?) {
        self.groupName = groupName
        self.groupDate = groupDate
        self.isMember = isMember
        self.memberName = memberName
    }
    
    static func == (lhs: ChatGroupModel, rhs: ChatGroupModel) -> Bool {
        return lhs.groupName == rhs.groupName && lhs.groupDate == rhs.groupDate && lhs.isMember == rhs.isMember && lhs.memberName == rhs.memberName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(groupName)
        hasher.combine(groupDate)
        hasher.combine(isMember)
        hasher.combine(memberName)
    }
}
