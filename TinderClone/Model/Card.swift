//
//  Card.swift
//  TinderClone
//
//  Created by 福田瑛斗 on 2023/10/28.
//

import Foundation


struct Card: Identifiable, Hashable {
    
    let id = UUID()
    let user: User
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    var degree: CGFloat = 0.0
    
    static var mockData: [Card] = [
        Card(user: User.mockUsers[0]),
        Card(user: User.mockUsers[1]),
        Card(user: User.mockUsers[2]),
        Card(user: User.mockUsers[3]),
        Card(user: User.mockUsers[4]),
        Card(user: User.mockUsers[5]),
        Card(user: User.mockUsers[6]),
        Card(user: User.mockUsers[7]),
        Card(user: User.mockUsers[8]),
        Card(user: User.mockUsers[9]),
    ]
}
