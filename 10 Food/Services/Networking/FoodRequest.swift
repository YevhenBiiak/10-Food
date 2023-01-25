//
//  FoodRequest.swift
//  10 Food
//
//  Created by Yevhen Biiak on 24.01.2023.
//

import Foundation

struct FoodRequest: NetworkRequest {
    
    var url: URL = URL(string: "https://raw.githubusercontent.com/YevhenBiiak/10-Food/main/Resources/FoodData.json")!
    
    func decode(_ data: Data) throws -> [FoodGroup] {
        if let wrapper = try? JSONDecoder().decode(Wrapper.self, from: data) {
            return wrapper.foodGroups
        }
        throw NetworkRequestError.decodingError
    }
}

struct Wrapper: Decodable {
    let foodGroups: [FoodGroup]
    enum CodingKeys: String, CodingKey {
        case foodGroups = "food_groups"
    }
}

extension FoodGroup {
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case imageURL = "image_url"
        case foodItems = "food_items"
    }
}

extension FoodItem {
    enum CodingKeys: String, CodingKey {
        case id, name, description, weight, price
        case imageURL = "image_url"
    }
}
