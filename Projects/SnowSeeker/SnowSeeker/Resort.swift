//
//  Resort.swift
//  SnowSeeker
//
//  Created by Jared Pateman on 21/10/2023.
//

import Foundation

struct Resort: Identifiable, Codable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    
    // Same result as 1 liner
    // static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
}
