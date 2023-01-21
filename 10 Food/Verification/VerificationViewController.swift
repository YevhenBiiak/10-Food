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
            guard let self else { return }
            self.transparentСodeField.text = viewModel.verificationCode
            self.updateLabel(self.firstNumberLabel, with: viewModel.verificationCode?[0])
            self.updateLabel(self.secondNumberLabel, with: viewModel.verificationCode?[1])
            self.updateLabel(self.thirdNumberLabel, with: viewModel.verificationCode?[2])
            self.updateLabel(self.fourthNumberLabel, with: viewModel.verificationCode?[3])
            if let error = viewModel.verificationError {
                print(error)
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
    
    private func updateLabel(_ label: UILabel, with text: String?) {
        label.isHidden = text == nil
        label.text = text
    }
}

extension String {
    
    subscript(_ index: Int) -> String? {
        guard self.count > index else { return nil }
        return String(self.prefix(index + 1).last!)
    }
}
