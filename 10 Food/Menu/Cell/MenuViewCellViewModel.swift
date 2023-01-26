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
    var cartAmount: Int { get }
    func add(_ foodItem: FoodItem)
    func remove(_ foodItem: FoodItem)
    func count(of foodItem: FoodItem) -> Int
}

protocol MenuViewCellViewModel {
    var title: String { get }
    var subtitle: String { get }
    var weight: String { get }
    var price: String { get }
    var image: UIImage? { get }
    var isFavorite: Bool { get }
    var orderedQty: Int { get }
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
    var orderedQty: Int {
        didSet { onUpdate?(self) }
    }
    var error: String? {
        didSet { onUpdate?(self) }
    }
    var onUpdate: ((MenuViewCellViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    private let foodItem: FoodItem
    private let onAddButtonTap: () -> Void
    private let ordersManager: OrdersManager?
    private let favoritesManager: FavoritesManager?
    
    init(foodItem: FoodItem, onAddButtonTap: @escaping () -> Void) {
        self.foodItem = foodItem
        self.onAddButtonTap = onAddButtonTap
        self.ordersManager = UIApplication.shared.sceneDelegate?.ordersRepository
        self.favoritesManager = UIApplication.shared.sceneDelegate?.favoritesRepository
        
        title = foodItem.name
        subtitle = foodItem.description
        weight = "\(foodItem.weight) g"
        price = "\(foodItem.price) UAH"
        isFavorite = favoritesManager?.isFavorite(foodItem) == true
        orderedQty = ordersManager?.count(of: foodItem) ?? 0
        
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
            favoritesManager?.add(foodItem)
        } else {
            favoritesManager?.remove(foodItem)
        }
    }
    
    func addButtonTapped() {
        ordersManager?.add(foodItem)
        orderedQty = ordersManager?.count(of: foodItem) ?? 0
        onAddButtonTap()
    }
}
