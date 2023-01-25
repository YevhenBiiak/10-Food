//
//  MenuViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import Foundation

protocol MenuViewModel {
    var foodCount: Int { get }
    func cellViewModel(at indexPath: IndexPath) -> MenuViewCellViewModel
}

class MenuViewModelImpl: MenuViewModel {
    
    var foodCount: Int {
        foodGroup.foodItems.count
    }
    
    private let foodGroup: FoodGroup
    
    init(foodGroup: FoodGroup) {
        self.foodGroup = foodGroup
    }
    
    func cellViewModel(at indexPath: IndexPath) -> MenuViewCellViewModel {
        MenuViewCellViewModelImpl(foodItem: foodGroup.foodItems[indexPath.row])
    }
}
