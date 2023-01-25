//
//  MenuViewCellViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import UIKit

protocol MenuViewCellViewModel {
    var title: String { get }
    var subtitle: String { get }
    var price: String { get }
    var image: UIImage? { get }
    var error: String? { get }
    var onUpdate: ((MenuViewCellViewModel) -> Void)? { get set }
}

class MenuViewCellViewModelImpl: MenuViewCellViewModel {
    
    var title: String
    var subtitle: String
    var price: String
    var image: UIImage? {
        didSet { onUpdate?(self) }
    }
    var error: String? {
        didSet { onUpdate?(self) }
    }
    var onUpdate: ((MenuViewCellViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    init(foodItem: FoodItem) {
        title = foodItem.name
        subtitle = foodItem.description
        price = "\(foodItem.price) UAH"
        
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
}
