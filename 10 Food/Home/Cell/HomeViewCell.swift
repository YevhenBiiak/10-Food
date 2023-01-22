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
            cellImageView.image = UIImage(data: viewModel.imageData)
            titleLabel.text = viewModel.title
            subtitleLabel.text = viewModel.subtitle
        }
    }
}
