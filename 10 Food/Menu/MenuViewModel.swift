//
//  MenuViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import UIKit

protocol MenuViewModel {
    var title: String { get }
    var cartAmount: String { get }
    var foodCount: Int { get }
    var onUpdate: ((MenuViewModel) -> Void)? { get set }
    func cellViewModel(at indexPath: IndexPath) -> MenuViewCellViewModel
    func ingredientsViewModel(for indexPath: IndexPath) -> IngredientsViewModel
}

class MenuViewModelImpl: MenuViewModel {
    
    var title: String {
        foodGroup.name
    }
    
    var cartAmount: String {
        "\(ordersManager?.cartAmount ?? 0)"
    }
    
    var foodCount: Int {
        foodGroup.foodItems.count
    }
    
    var onUpdate: ((MenuViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    private let foodGroup: FoodGroup
    private let ordersManager: OrdersManager?
    
    init(foodGroup: FoodGroup) {
        self.foodGroup = foodGroup
        self.ordersManager = UIApplication.shared.sceneDelegate?.ordersRepository
        self.ordersManager?.observe(self, selector: #selector(ordersListDidChange))
    }
    
    func cellViewModel(at indexPath: IndexPath) -> MenuViewCellViewModel {
        return MenuViewCellViewModelImpl(foodItem: foodGroup.foodItems[indexPath.row])
    }
    
    func ingredientsViewModel(for indexPath: IndexPath) -> IngredientsViewModel {
        IngredientsViewModelImpl(foodItem: foodGroup.foodItems[indexPath.row])
    }
    
    @objc private func ordersListDidChange() {
        onUpdate?(self)
    }
}
