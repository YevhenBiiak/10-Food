//
//  OrderItem.swift
//  10 Food
//
//  Created by Yevhen Biiak on 25.01.2023.
//

import Foundation

struct OrderItem: Identifiable, Codable {
    var id = UUID().uuidString
    let foodItem: FoodItem
    let amount: Int
}
