//
//  MenuViewCell.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import UIKit

class MenuViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var viewModel: MenuViewCellViewModel! {
        didSet {
            titleLabel.text = viewModel.title
            subtitleLabel.text = viewModel.subtitle
            weightLabel.text = viewModel.weight
            priceLabel.text = viewModel.price
            cellImageView.image = viewModel.image
            
            viewModel.onUpdate = { [weak self] viewModel in
                if let error = viewModel.error {
                    UIApplication.shared.window?.rootViewController?.showAlert(title: "Error", message: error)
                }
                self?.cellImageView.image = viewModel.image
                
                let favoriteImage = viewModel.isFavorite
                    ? UIImage(systemName: "bookmark.fill")
                    : UIImage(systemName: "bookmark")
                self?.favoriteButton.setImage(favoriteImage, for: .normal)
                
                let addImage = viewModel.orderedQty > 0
                    ? UIImage(systemName: "\(viewModel.orderedQty).circle.fill")
                    : UIImage(systemName: "cart.badge.plus")
                self?.addButton.setImage(addImage, for: .normal)
            }
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        viewModel.favoriteButtonTapped()
    }
    @IBAction func addToOrderButtonTapped(_ sender: UIButton) {
        viewModel.addButtonTapped()
    }
}
