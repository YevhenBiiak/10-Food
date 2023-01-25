//
//  HomeViewCellViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import UIKit

protocol HomeViewCellViewModel {
    var title: String { get }
    var subtitle: String { get }
    var image: UIImage? { get }
    var error: String? { get }
    var onUpdate: ((HomeViewCellViewModel) -> Void)? { get set }
}

class HomeViewCellViewModelImpl: HomeViewCellViewModel {
    
    var title: String
    var subtitle: String
    var image: UIImage? {
        didSet { onUpdate?(self) }
    }
    var error: String? {
        didSet { onUpdate?(self) }
    }
    var onUpdate: ((HomeViewCellViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    init(foodGroup: FoodGroup) {
        title = foodGroup.name
        subtitle = foodGroup.description
        
        guard let url = foodGroup.imageURL else { return }
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
