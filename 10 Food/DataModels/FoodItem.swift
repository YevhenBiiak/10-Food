//
//  FoodItem.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import Foundation

struct FoodItem: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let weight: Int
    let price: Int
    let imageURL: URL?
}
