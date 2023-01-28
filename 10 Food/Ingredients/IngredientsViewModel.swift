//
//  IngredientsViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import UIKit

protocol IngredientsViewModel {
    var title: String { get }
    var ingredients: String { get }
    var image: UIImage? { get }
    var price: String { get }
    var error: String? { get }
    var onUpdate: ((IngredientsViewModel) -> Void)? { get set }
    func addButtonTapped()
}

class IngredientsViewModelImpl: IngredientsViewModel {
    
    var title: String
    var ingredients: String
    var price: String
    var image: UIImage? {
        didSet { onUpdate?(self) }
    }
    var error: String? {
        didSet { onUpdate?(self) }
    }
    var onUpdate: ((IngredientsViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    private let foodItem: FoodItem
    private let ordersManager: OrdersManager?
    
    init(foodItem: FoodItem) {
        self.foodItem = foodItem
        self.ordersManager = UIApplication.shared.sceneDelegate?.ordersRepository
        
        title = foodItem.name.uppercased()
        price = "\(foodItem.price).00 ₴"
        ingredients = foodItem.description.components(separatedBy: ",")
            .map { "• " + $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
            .joined(separator: "\n")
        
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
    
    func addButtonTapped() {
        guard let count = ordersManager?.count(of: foodItem), count < 10 else { return }
        ordersManager?.add(foodItem)
    }
}
