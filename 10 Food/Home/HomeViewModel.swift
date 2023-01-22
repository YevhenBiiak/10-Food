//
//  HomeViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 19.01.2023.
//

import Foundation

protocol HomeViewModel {
    var foodCount: Int { get }
    func cellViewModel(at indexPath: IndexPath) -> HomeViewCellViewModel
}

class HomeViewModelImpl: HomeViewModel {
    
    var foodCount: Int {
        foodGroups.count
    }
    
    private let user: User
    private var foodGroups: [FoodGroup] = []
    
    init(user: User, dataSource: DataSource<FoodGroup>) {
        self.user = user
        dataSource.obtainData { [weak self] food in
            self?.foodGroups = food
        }
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HomeViewCellViewModel {
        FoodCellViewModelImpl(foodGroup: foodGroups[indexPath.row])
    }
}
