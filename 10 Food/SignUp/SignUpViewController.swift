//
//  SignUpViewController.swift
//  10 Food
//
//  Created by Yevhen Biiak on 17.01.2023.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var viewModel: SignUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onUpdate = { [weak self] viewModel in
            guard let self else { return }
            self.promptLabel.text = viewModel.prompt
            self.phoneField.text = viewModel.phone
            self.nextButton.isEnabled = self.phoneField.hasText
        }

        self.observeKeyboardNotification(for: bottomConstraint)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            self.phoneField.becomeFirstResponder()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let verificationViewController = segue.destination as? VerificationViewController
        verificationViewController?.viewModel = viewModel.verificationViewModel()
    }
    
    @IBAction func phoneFieldEditingChanged(_ sender: UITextField) {
        viewModel.phoneChanged(sender.text)
    }
}
