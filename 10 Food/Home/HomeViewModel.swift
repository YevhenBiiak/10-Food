//
//  HomeViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 19.01.2023.
//

import Foundation

protocol FoodDataSource {
    func obtainData(_ completion: @escaping (Result<[FoodGroup], Error>) -> Void)
}

protocol HomeViewModel {
    var error: String? { get }
    var foodCount: Int { get }
    var onUpdate: ((HomeViewModel) -> Void)? { get set }
    func cellViewModel(at indexPath: IndexPath) -> HomeViewCellViewModel
    func menuViewModel(for indexPath: IndexPath) -> MenuViewModel
}

class HomeViewModelImpl: HomeViewModel {
    
    var error: String? {
        didSet { onUpdate?(self) }
    }
    var foodCount: Int {
        foodGroups.count
    }
    var onUpdate: ((HomeViewModel) -> Void)?
    
    private let user: User
    private var foodGroups: [FoodGroup] = [] {
        didSet { onUpdate?(self) }
    }
    
    init(user: User) {
        self.user = user
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
}

