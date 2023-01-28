//
//  OrderViewCell.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import UIKit

class OrderViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var detailPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    var viewModel: OrderViewCellViewModel! {
        didSet {
            titleLabel.text = viewModel.title
            subtitleLabel.text = viewModel.subtitle
            detailPriceLabel.text = viewModel.detailPrice
            totalPriceLabel.text = viewModel.totalPrice
            cellImageView.image = viewModel.image
            
            viewModel.onUpdate = { [weak self] viewModel in
                if let error = viewModel.error {
                    UIApplication.shared.window?.rootViewController?.showAlert(title: "Error", message: error)
                }
                self?.cellImageView.image = viewModel.image
            }
        }
    }
    
}
