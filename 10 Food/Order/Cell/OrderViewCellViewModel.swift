//
//  OrderViewCellViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import UIKit

protocol OrderViewCellViewModel {
    var title: String { get }
    var subtitle: String { get }
    var detailPrice: String { get }
    var totalPrice: String { get }
    var image: UIImage? { get }
    var error: String? { get }
    var onUpdate: ((OrderViewCellViewModel) -> Void)? { get set }
}

class OrderViewCellViewModelImpl: OrderViewCellViewModel {
    
    var title: String
    var subtitle: String
    var detailPrice: String
    var totalPrice: String
    var image: UIImage? {
        didSet { onUpdate?(self) }
    }
    var error: String? {
        didSet { onUpdate?(self) }
    }
    var onUpdate: ((OrderViewCellViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    private let orderItem: OrderItem
    
    init(orderItem: OrderItem) {
        self.orderItem = orderItem
        
        title = orderItem.foodItem.name
        subtitle = orderItem.foodItem.description
        detailPrice = "\(orderItem.qty) X \(orderItem.foodItem.price) ₴"
        totalPrice = "\(orderItem.qty * orderItem.foodItem.price).00 ₴"
        
        guard let url = orderItem.foodItem.imageURL else { return }
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
}
