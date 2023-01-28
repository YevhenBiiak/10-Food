//
//  OrderViewController.swift
//  10 Food
//
//  Created by Yevhen Biiak on 17.01.2023.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet var confirmButtons: [UIButton]!
    
    var viewModel: OrderViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onUpdate = { [weak self] viewModel in
            self?.totalAmountLabel.text = viewModel.totalAmount
            self?.confirmButtons.forEach { $0.isEnabled = viewModel.foodCount > 0 }
            DispatchQueue.main.async {
                self?.reloadData(animated: true)
            }
        }
    }
    
    @IBAction func confirmOrderButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ShowGratitudeMessage", sender: nil)
        viewModel.confirmButtonTapped()
    }
    
    @IBAction func confirmAndPayButtonTapped(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.performSegue(withIdentifier: "ShowGratitudeMessage", sender: nil)
        }
        viewModel.confirmButtonTapped()
    }
    
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

extension OrderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.foodCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath) as! OrderViewCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension OrderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let increaseAction = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, completion) in
            self?.viewModel.increaseAction(at: indexPath)
            completion(true)
        }
        increaseAction.image = UIImage(systemName: "plus.square.fill")
        increaseAction.backgroundColor = UIColor.systemGreen
        
        return UISwipeActionsConfiguration(actions: [increaseAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let decreaseAction = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, completion) in
            self?.viewModel.decreaseAction(at: indexPath)
            completion(true)
        }
        decreaseAction.image = UIImage(systemName: "minus.square.fill")
        decreaseAction.backgroundColor = UIColor.systemRed
        
        return UISwipeActionsConfiguration(actions: [decreaseAction])
    }
}
