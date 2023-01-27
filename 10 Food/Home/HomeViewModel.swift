//
//  HomeViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 19.01.2023.
//

import UIKit

protocol HomeViewModel {
    var cartAmount: String { get }
    var foodCount: Int { get }
    var error: String? { get }
    var onUpdate: ((HomeViewModel) -> Void)? { get set }
    func cellViewModel(at indexPath: IndexPath) -> HomeViewCellViewModel
    func menuViewModel(for indexPath: IndexPath) -> MenuViewModel
}

class HomeViewModelImpl: HomeViewModel {
    
    var cartAmount: String {
        "\(ordersManager?.cartAmount ?? 0)"
    }
    
    var foodCount: Int {
        foodGroups.count
    }
    
    var error: String? {
        didSet { onUpdate?(self) }
    }
    
    var onUpdate: ((HomeViewModel) -> Void)?
    
    private let user: User
    private let ordersManager: OrdersManager?
    private var foodGroups: [FoodGroup] = [] {
        didSet { onUpdate?(self) }
    }
    
    init(user: User) {
        self.user = user
        self.ordersManager = UIApplication.shared.sceneDelegate?.ordersRepository
        self.ordersManager?.observe(self, selector: #selector(ordersListDidChange))
        
        obtainData()
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HomeViewCellViewModel {
        HomeViewCellViewModelImpl(foodGroup: foodGroups[indexPath.row])
    }
    
    func menuViewModel(for indexPath: IndexPath) -> MenuViewModel {
        MenuViewModelImpl(foodGroup: foodGroups[indexPath.row])
    }
    
    private func obtainData() {
        let foodRequest = FoodRequest()
        foodRequest.execute { [weak self] result in
            switch result {
            case .success(let foodGroups):
                self?.foodGroups = foodGroups
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        }
    }
    
    @objc private func ordersListDidChange() {
        onUpdate?(self)
    }
}
