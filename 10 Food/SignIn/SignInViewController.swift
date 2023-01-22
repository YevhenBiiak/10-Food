//
//  SignInViewController.swift
//  10 Food
//
//  Created by Yevhen Biiak on 16.01.2023.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var pagingScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var viewModel: SignInViewModel!
    
    // MARK: - Life Cycle and overridden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        viewModel.onUpdate = { [weak self] viewModel in
            if let error = viewModel.signInError {
                self?.showAlert(title: nil, message: error)
            }
            if let homeViewModel = viewModel.homeViewModel {
                self?.presentHomeViewController(with: homeViewModel)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setTopInsetForContentScrollView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let signUpViewController = segue.destination as? SignUpViewController
        signUpViewController?.viewModel = viewModel.signUpViewModel()
    }
    
    @IBAction func phoneFieldEditingChange(_ sender: UITextField) {
        viewModel.phoneChanged(phone: phoneField.text)
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let phone = phoneField.text,
              let password = passwordField.text
        else { return }
        
        viewModel.signInButtonTapped(phone: phone, password: password)
    }
}

// MARK: - Extension for Private methods

extension SignInViewController {
    
    private func presentHomeViewController(with viewModel: HomeViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        
        (homeViewController as? HomeViewController)?.viewModel = viewModel
        navigationController?.setViewControllers([homeViewController], animated: true)
    }
    
    func setTopInsetForContentScrollView() {
        let topBarHeight = (statusBarHeight ?? 0) + (navigationBarHeight ?? 0)
        contentScrollView.contentInset.top = -topBarHeight
    }
    
    private func setupViews() {
        self.observeKeyboardNotification(for: bottomConstraint, adjustOffsetFor: contentScrollView)
        
        pagingScrollView.delegate = self
        contentScrollView.delegate = self
                
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
                
        setupImagePaging()
    }
    
    private func setupImagePaging() {
        let images = [
            UIImage(named: "pizza1"),
            UIImage(named: "chinese1"),
            UIImage(named: "pizza2"),
            UIImage(named: "chinese2"),
            UIImage(named: "pizza3"),
            UIImage(named: "chinese3")
        ]
        
        for (i, image) in images.enumerated() {
            let width = view.frame.width
            let height = pagingScrollView.frame.height
            
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height)
            imageView.clipsToBounds = true
            
            pagingScrollView.addSubview(imageView)
            pagingScrollView.contentSize = CGSize(width: CGFloat(i + 1) * width, height: height)
        }
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
    }
}

// MARK: - UIScrollViewDelegate

extension SignInViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // set page for pageControl
        pageControl.currentPage = lround(pagingScrollView.contentOffset.x / view.frame.width)
        
        // top bounce constraint for contentScrollView
        if contentScrollView.contentOffset.y < -20 { contentScrollView.contentOffset.y = -20 }
    }
}
