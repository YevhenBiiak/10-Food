//
//  SplashViewController.swift
//  10 Food
//
//  Created by Yevhen Biiak on 28.01.2023.
//

import UIKit

class SplashViewController: UIViewController {
    
    var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = self.authService.currentUser() {
            // present HomeViewController from Main storyboard
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
            let homeViewModel = HomeViewModelImpl(user: user)
            
            (homeViewController as? HomeViewController)?.viewModel = homeViewModel
            navigationController?.setViewControllers([homeViewController], animated: true)
            
        } else {
            // present AuthViewController from Auth storyboard
            
            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
            let signInViewController = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
            let signInViewModel = SignInViewModelImpl(authService: authService)
            
            (signInViewController as? SignInViewController)?.viewModel = signInViewModel
            navigationController?.setViewControllers([signInViewController], animated: true)
        }
    }
}
