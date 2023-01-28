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
    var orderItems: [OrderItem] { get }
    func add(_ foodItem: FoodItem)
    func remove(_ foodItem: FoodItem)
    func removeAll()
    func count(of foodItem: FoodItem) -> Int
    func observe(_ observer: Any, selector: Selector)
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
    var isFavorite: Bool { favoritesManager?.isFavorite(foodItem) == true }
    var orderedQty: Int { ordersManager?.count(of: foodItem) ?? 0 }
    var image: UIImage? {
        didSet { onUpdate?(self) }
    }
    var error: String? {
        didSet { onUpdate?(self) }
    }
    var onUpdate: ((MenuViewCellViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    private let foodItem: FoodItem
    private let ordersManager: OrdersManager?
    private let favoritesManager: FavoritesManager?
    
    init(foodItem: FoodItem) {
        title = foodItem.name
        subtitle = foodItem.description
        weight = "\(foodItem.weight) g"
        price = "\(foodItem.price).00 ₴"
        
        self.foodItem = foodItem
        self.favoritesManager = UIApplication.shared.sceneDelegate?.favoritesRepository
        self.ordersManager = UIApplication.shared.sceneDelegate?.ordersRepository
        self.ordersManager?.observe(self, selector: #selector(ordersListDidChange))
        
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
        !isFavorite ? favoritesManager?.add(foodItem)
                    : favoritesManager?.remove(foodItem)
        onUpdate?(self)
    }
    
    func addButtonTapped() {
        guard let count = ordersManager?.count(of: foodItem), count < 10 else { return }
        ordersManager?.add(foodItem)
    }
    
    @objc private func ordersListDidChange() {
        onUpdate?(self)
    }
}
