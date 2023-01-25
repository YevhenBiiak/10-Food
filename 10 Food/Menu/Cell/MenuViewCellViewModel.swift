//
//  MenuViewCellViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import UIKit

protocol FavoritesManager {
    func isFavorite(_ foodItem: FoodItem) -> Bool
    func add(_ foodItem: FoodItem)
    func remove(_ foodItem: FoodItem)
}

protocol OrdersManager {
    func add(_ orderItem: OrderItem)
    func remove(_ orderItem: OrderItem)
}

protocol MenuViewCellViewModel {
    var title: String { get }
    var subtitle: String { get }
    var weight: String { get }
    var price: String { get }
    var image: UIImage? { get }
    var isFavorite: Bool { get }
    var error: String? { get }
    var onUpdate: ((MenuViewCellViewModel) -> Void)? { get set }
    func favoriteButtonTapped()
    func addButtonTapped()
}

class MenuViewCellViewModelImpl: MenuViewCellViewModel {
    
    var title: String
    var subtitle: String
    var weight: String
    var price: String
    var image: UIImage? {
        didSet { onUpdate?(self) }
    }
    var isFavorite: Bool {
        didSet { onUpdate?(self) }
    }
    var error: String? {
        didSet { onUpdate?(self) }
    }
    var onUpdate: ((MenuViewCellViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    private let foodItem: FoodItem
    private let ordersManager: OrdersManager
    private let favoritesManager: FavoritesManager
    
    init(foodItem: FoodItem,
         ordersManager: OrdersManager,
         favoritesManager: FavoritesManager
    ) {
        self.foodItem = foodItem
        self.ordersManager = ordersManager
        self.favoritesManager = favoritesManager
        
        title = foodItem.name
        subtitle = foodItem.description
        weight = "\(foodItem.weight) g"
        price = "\(foodItem.price) UAH"
        isFavorite = favoritesManager.isFavorite(foodItem)
        
        guard let url = foodItem.imageURL else { return }
        let imageRequest = ImageRequest(url: url)
        imageRequest.execute { [weak self] result in
            switch result {
            case .success(let image):
                self?.image = image
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        }
    }
    
    func favoriteButtonTapped() {
        isFavorite.toggle()
        if isFavorite {
            favoritesManager.add(foodItem)
        } else {
            favoritesManager.remove(foodItem)
        }
    }
    
    func addButtonTapped() {
        let orderItem = OrderItem(foodItem: foodItem, amount: 1)
        ordersManager.add(orderItem)
    }
}
