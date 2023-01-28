//
//  OrderViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import UIKit

protocol OrderViewModel {
    var totalAmount: String { get }
    var foodCount: Int { get }
    var onUpdate: ((OrderViewModel) -> Void)? { get set }
    func cellViewModel(at indexPath: IndexPath) -> OrderViewCellViewModel
    func increaseAction(at indexPath: IndexPath)
    func decreaseAction(at indexPath: IndexPath)
    func confirmButtonTapped()
}

class OrderViewModelImpl: OrderViewModel {
    
    var totalAmount: String { "\(ordersManager?.cartAmount ?? 0).00 ₴" }
    var foodCount: Int { orderItems.count }
    var onUpdate: ((OrderViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    private var orderItems: [OrderItem] { ordersManager?.orderItems ?? [] }
    private let ordersManager: OrdersManager?
    
    init() {
        self.ordersManager = UIApplication.shared.sceneDelegate?.ordersRepository
        self.ordersManager?.observe(self, selector: #selector(ordersListDidChange))
    }
    
    func cellViewModel(at indexPath: IndexPath) -> OrderViewCellViewModel {
        return OrderViewCellViewModelImpl(orderItem: orderItems[indexPath.row])
    }
    
    func increaseAction(at indexPath: IndexPath) {
        let foodItem = orderItems[indexPath.row].foodItem
        ordersManager?.add(foodItem)
    }
    
    func decreaseAction(at indexPath: IndexPath) {
        let orderItem = orderItems[indexPath.row]
        ordersManager?.remove(orderItem.foodItem)
    }
    
    func confirmButtonTapped() {
        ordersManager?.removeAll()
    }
    
    @objc private func ordersListDidChange() {
        onUpdate?(self)
    }
}
