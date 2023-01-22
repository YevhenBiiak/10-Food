//
//  HomeViewCellViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import Foundation

protocol HomeViewCellViewModel {
    var imageData: Data { get }
    var title: String { get }
    var subtitle: String { get }
}

class FoodCellViewModelImpl: HomeViewCellViewModel {
    
    var imageData: Data
    var title: String
    var subtitle: String
        
    init(foodGroup: FoodGroup) {
        imageData = foodGroup.imageData
        title = foodGroup.name
        subtitle = foodGroup.description
    }
}
