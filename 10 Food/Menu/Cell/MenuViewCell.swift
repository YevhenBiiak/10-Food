//
//  MenuViewCell.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import UIKit

class MenuViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var viewModel: MenuViewCellViewModel! {
        didSet {
            titleLabel.text = viewModel.title
            subtitleLabel.text = viewModel.subtitle
            priceLabel.text = viewModel.price
            viewModel.onUpdate = { [weak self] viewModel in
                if let error = viewModel.error {
                    UIApplication.shared.window?.rootViewController?.showAlert(title: "Error", message: error)
                }
                if let image = viewModel.image {
                    self?.cellImageView.image = image
                } else {
                    self?.cellImageView.image = nil
                }
            }
        }
    }
}
