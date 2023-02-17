//
//  ListViewModel.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/16.
//

import Foundation

class ListViewModel {
    
    var dataList: [MatchInfo] = [MatchInfo(
        event: "축구",
        title: "공원 매치구함",
        body: "저녁 8시 11대11",
        date: Date(),
        location: "공원",
        images: .init()
    )]
}
