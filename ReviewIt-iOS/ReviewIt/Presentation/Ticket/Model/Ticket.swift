//
//  Ticket.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import Foundation

struct Ticket: Codable {
    let id: Int
    let title: String
    let date: Date
    let cast: [String]
    let place: String
    let seat: [String]
    let platform: String
    let price: Int
    
    let reviewStatus: Bool
    
    let type1: [Int]
    let type2: [Int]
    let type3: [Int]
    let type4: [Int]
    let type5: [Int]
}
