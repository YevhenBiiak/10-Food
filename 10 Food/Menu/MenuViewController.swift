//
//  MenuViewController.swift
//  10 Food
//
//  Created by Yevhen Biiak on 17.01.2023.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var cartAmountLabel: UILabel!
    
    var viewModel: MenuViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        
        viewModel.onUpdate = { [weak self] viewModel in
            self?.cartAmountLabel.text = viewModel.cartAmount
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowOrder" {
            let menuViewController = segue.destination as? OrderViewController
            menuViewController?.viewModel = viewModel.orderViewModel()
        } else if let indexPath = sender as? IndexPath, segue.identifier == "ShowIngredients" {
            let ingredientsViewController = segue.destination as? IngredientsViewController
            ingredientsViewController?.viewModel = viewModel.ingredientsViewModel(for: indexPath)
        }
    }
}

// MARK: - UITableViewDataSource

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.foodCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuViewCell", for: indexPath) as! MenuViewCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowIngredients", sender: indexPath)
    }
}

