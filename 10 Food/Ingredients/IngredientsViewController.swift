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
    @IBOutlet weak var ingredientsStackView: UIStackView!
    
    var viewModel: IngredientsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addToppingButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func addToOrderButtonTapped(_ sender: UIButton) {
        
    }
}
