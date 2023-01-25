//
//  VerificationViewController.swift
//  10 Food
//
//  Created by Yevhen Biiak on 17.01.2023.
//

import UIKit

class VerificationViewController: UIViewController {

    @IBOutlet weak var firstNumberLabel: UILabel!
    @IBOutlet weak var secondNumberLabel: UILabel!
    @IBOutlet weak var thirdNumberLabel: UILabel!
    @IBOutlet weak var fourthNumberLabel: UILabel!
    @IBOutlet weak var transparentСodeField: UITextField!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var viewModel: VerificationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onUpdate = { [weak self] viewModel in
            self?.updateVirificationCodeView(with: viewModel.verificationCode)
            if let error = viewModel.verificationError {
                // shake animation
                UIApplication.shared.window?.rootViewController?.showAlert(title: "Error", message: error)
            }
            if let homeViewModel = viewModel.homeViewModel {
                self?.presentHomeViewController(with: homeViewModel)
            }
        }
        
        self.observeKeyboardNotification(for: bottomConstraint, adjustOffsetFor: contentScrollView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            self.transparentСodeField.becomeFirstResponder()
        }
    }
    
    @IBAction func codeFieldEditingChanged(_ codeField: UITextField) {
        viewModel.codeChanged(code: codeField.text)
    }
    
    @IBAction func resentCodeButtonTapped(_ sender: UIButton) {
        viewModel.resentCode()
    }
    
    private func updateVirificationCodeView(with code: String?) {
        transparentСodeField.text = code
        
        updateLabel(firstNumberLabel, with: code?[0])
        updateLabel(secondNumberLabel, with: code?[1])
        updateLabel(thirdNumberLabel, with: code?[2])
        updateLabel(fourthNumberLabel, with: code?[3])
        
        func updateLabel(_ label: UILabel, with text: String?) {
            label.isHidden = text == nil
            label.text = text
        }
    }
    
    private func presentHomeViewController(with viewModel: HomeViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        
        (homeViewController as? HomeViewController)?.viewModel = viewModel
        navigationController?.setViewControllers([homeViewController], animated: true)
    }
}

extension String {
    
    subscript(_ index: Int) -> String? {
        guard self.count > index else { return nil }
        return String(self.prefix(index + 1).last!)
    }
}
