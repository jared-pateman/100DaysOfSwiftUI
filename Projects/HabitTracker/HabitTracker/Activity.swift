//
//  Activity.swift
//  HabitTracker
//
//  Created by Jared Pateman on 27/08/2023.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    let id = UUID()
    let type: String
    let description: String
    let timesCompleted: Int
}
