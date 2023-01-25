//
//  MenuViewController.swift
//  10 Food
//
//  Created by Yevhen Biiak on 17.01.2023.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var viewModel: MenuViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
    }
}

