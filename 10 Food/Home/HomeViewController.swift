//
//  HomeViewController.swift
//  10 Food
//
//  Created by Yevhen Biiak on 17.01.2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartAmountLabel: UILabel!
    @IBOutlet weak var cartButton: UIBarButtonItem!
    
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onUpdate = { [weak self] viewModel in
            if let error = viewModel.error {
                UIApplication.shared.window?.rootViewController?.showAlert(title: "Error", message: error)
            }
            self?.cartAmountLabel.text = viewModel.cartAmount
            DispatchQueue.main.async {
                self?.reloadData(animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowOrder" {
            let menuViewController = segue.destination as? OrderViewController
            menuViewController?.viewModel = viewModel.orderViewModel()
        } else if let indexPath = sender as? IndexPath, segue.identifier == "ShowMenu" {
            let menuViewController = segue.destination as? MenuViewController
            menuViewController?.viewModel = viewModel.menuViewModel(for: indexPath)
        }
    }
    
    @IBAction func unwindToHome(_ segue: UIStoryboardSegue) {}
    
    private func reloadData(animated: Bool = false) {
        if animated {
            let indexSet = IndexSet(integersIn: 0..<tableView.numberOfSections)
            tableView.reloadSections(indexSet, with: .automatic)
        } else {
            tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.foodCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell", for: indexPath) as! HomeViewCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowMenu", sender: indexPath)
    }
}
