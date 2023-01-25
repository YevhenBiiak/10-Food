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
