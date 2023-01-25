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
    var error: String? { get }
    var onUpdate: ((IngredientsViewModel) -> Void)? { get set }
}

class IngredientsViewModelImpl: IngredientsViewModel {
    
    var title: String
    var ingredients: String
    var image: UIImage? {
        didSet { onUpdate?(self) }
    }
    var error: String? {
        didSet { onUpdate?(self) }
    }
    var onUpdate: ((IngredientsViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    init(foodItem: FoodItem) {
        title = foodItem.name
        ingredients = foodItem.description
        
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
