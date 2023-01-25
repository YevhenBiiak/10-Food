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
    func ingredientsViewModel(for indexPath: IndexPath) -> IngredientsViewModel
}

class MenuViewModelImpl: MenuViewModel {
    
    var foodCount: Int {
        foodGroup.foodItems.count
    }
    
    private let foodGroup: FoodGroup
    private lazy var ordersRepo: OrdersRepository = {
        let repo = OrdersRepository()
        repo.fetch()
        return repo
    }()
    private lazy var favoritesRepo: FavoritesRepository = {
        let repo = FavoritesRepository()
        repo.fetch()
        return repo
    }()
    
    init(foodGroup: FoodGroup) {
        self.foodGroup = foodGroup
    }
    
    func cellViewModel(at indexPath: IndexPath) -> MenuViewCellViewModel {
        return MenuViewCellViewModelImpl(foodItem: foodGroup.foodItems[indexPath.row],
                                         ordersManager: ordersRepo,
                                         favoritesManager: favoritesRepo)
    }
    
    func ingredientsViewModel(for indexPath: IndexPath) -> IngredientsViewModel {
        IngredientsViewModelImpl(foodItem: foodGroup.foodItems[indexPath.row])
    }
}
