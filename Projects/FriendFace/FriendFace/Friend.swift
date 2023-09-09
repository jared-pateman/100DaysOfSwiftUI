//
//  Friend.swift
//  FriendFace
//
//  Created by Jared Pateman on 09/09/2023.
//

import Foundation

struct Friend: Identifiable, Codable {
    let id: UUID
    let name: String
}
