//
//  FoodGroup.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import Foundation

struct FoodGroup: Decodable {
    let id: Int
    let name: String
    let description: String
    let imageURL: URL?
    let foodItems: [FoodItem]
}
