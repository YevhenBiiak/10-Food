//
//  HomeViewController.swift
//  10 Food
//
//  Created by Yevhen Biiak on 17.01.2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onUpdate = { [weak self] viewModel in
            self?.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath, segue.identifier == "ShowMenu" else { return }
        let menuViewController = segue.destination as? MenuViewController
        menuViewController?.viewModel = viewModel.menuViewModel(for: indexPath)
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
