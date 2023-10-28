//
//  User.swift
//  TinderClone
//
//  Created by 福田瑛斗 on 2023/10/28.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let email: String
    let name: String
    var age: Int?
    var bio: String?
    var profileImageUrl: String?
    
    static let mockUsers: [User] = [
        .init(id: NSUUID().uuidString, email: "u1@gmail.com", name: "u1", age: 28,bio: "u1bio", profileImageUrl: "ai_man1"),
        .init(id: NSUUID().uuidString, email: "u2@gmail.com", name: "u2", age: 28,bio: "u2bio", profileImageUrl: "ai_man2"),
        .init(id: NSUUID().uuidString, email: "u3@gmail.com", name: "u3", age: 28,bio: "u3bio", profileImageUrl: "ai_man3"),
        .init(id: NSUUID().uuidString, email: "u4@gmail.com", name: "u4", age: 28,bio: "u4bio", profileImageUrl: "ai_man4"),
        .init(id: NSUUID().uuidString, email: "u5@gmail.com", name: "u5", age: 28,bio: "u5bio", profileImageUrl: "ai_man5"),
        .init(id: NSUUID().uuidString, email: "u6@gmail.com", name: "u6", age: 28,bio: "u6bio", profileImageUrl: "ai_woman1"),
        .init(id: NSUUID().uuidString, email: "u7@gmail.com", name: "u7", age: 28,bio: "u7bio", profileImageUrl: "ai_woman2"),
        .init(id: NSUUID().uuidString, email: "u8@gmail.com", name: "u8", age: 28,bio: "u8bio", profileImageUrl: "ai_woman3"),
        .init(id: NSUUID().uuidString, email: "u9@gmail.com", name: "u9", age: 28,bio: "u9bio", profileImageUrl: "ai_woman4"),
        .init(id: NSUUID().uuidString, email: "u10@gmail.com", name: "u10", age: 28,bio: "u10bio", profileImageUrl: "ai_woman5"),
    ]
}
