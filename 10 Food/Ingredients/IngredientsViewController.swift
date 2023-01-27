//
//  IngredientsViewController.swift
//  10 Food
//
//  Created by Yevhen Biiak on 17.01.2023.
//

import UIKit

class IngredientsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var viewModel: IngredientsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = viewModel.title
        ingredientsLabel.text = viewModel.ingredients
        addButton.setTitle(viewModel.price, for: .normal)
        
        viewModel.onUpdate = { [weak self] viewModel in
            if let error = viewModel.error {
                UIApplication.shared.window?.rootViewController?.showAlert(title: "Error", message: error)
            }
            self?.imageView.image = viewModel.image
        }
    }
    
    @IBAction func addToOrderButtonTapped(_ sender: UIButton) {
        viewModel.addButtonTapped()
        dismiss(animated: true)
    }
}
