//
//  HomeViewCell.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

import UIKit

class HomeViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var viewModel: HomeViewCellViewModel! {
        didSet {
            titleLabel.text = viewModel.title
            subtitleLabel.text = viewModel.subtitle
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
