//
//  ListViewModel.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/16.
//

import Foundation

class ListViewModel {
    
    var dataList: [Restaurant] = [Restaurant(
        visitDate: Date(),
        visitRecord: [Date()],
        title: "123",
        body: "321",
        location: "123",
        score: 2,
        menu: ["123"],
        menuScore: [2]
    )]
}
