//
//  Restaurant.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/16.
//

import Foundation

struct Restaurant: Hashable {
    let visitDate: Date
    let visitRecord: [Date]
    let title: String
    let body: String
    let location: String
    let score: Int
    let menu: [String]
    let menuScore: [Int]
}
