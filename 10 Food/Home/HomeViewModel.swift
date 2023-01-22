//
//  HomeViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 19.01.2023.
//

import Foundation

protocol HomeViewModel {
    
}

class HomeViewModelImpl: HomeViewModel {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
}
