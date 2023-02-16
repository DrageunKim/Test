//
//  Identifiable.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/16.
//

protocol Identifiable {}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}
