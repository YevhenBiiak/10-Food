//
//  UIViewController + .swift
//  10 Food
//
//  Created by Yevhen Biiak on 18.01.2023.
//

import UIKit

extension UIViewController {
    var statusBarHeight: CGFloat? {
        UIApplication.shared.statusBarHeight
    }
    
    var navigationBarHeight: CGFloat? {
        navigationController?.navigationBar.frame.height
    }
}

extension UIViewController {
    func showAlert(title: String?, message: String?, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension UIViewController {
    // MARK: AssociatedKey
    
    private struct AssociatedKeys {
        static var defaultConstant = "defaultConstant"
        static var constraint = "constraint"
        static var scrollView = "scrollView"
    }
    
    // MARK: Stored properties
    
    private weak var constraint: NSLayoutConstraint? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.constraint) as? NSLayoutConstraint
        } set {
            objc_setAssociatedObject(self, &AssociatedKeys.constraint, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var defaultConstant: CGFloat? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.defaultConstant) as? CGFloat
        } set {
            objc_setAssociatedObject(self, &AssociatedKeys.defaultConstant, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private weak var scrollView: UIScrollView? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.scrollView) as? UIScrollView
        } set {
            objc_setAssociatedObject(self, &AssociatedKeys.scrollView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: Public method
    
    public func observeKeyboardNotification(for constraint: NSLayoutConstraint?, adjustOffsetFor scrollView: UIScrollView? = nil) {
        
        // remove observers of this object
        NotificationCenter.default.removeObserver(self)
        // add new observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrameSelector), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // save constraint and constant
        self.constraint = constraint
        self.defaultConstant = constraint?.constant
        
        // save scrollView
        self.scrollView = scrollView
    }
    
    // MARK: Private notification selector
    
    @objc private func keyboardWillChangeFrameSelector(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let focusedField = UIResponder.firstResponder() as? UITextField
        else { return }
        
        let keyboardHeigh = keyboardFrame.height - view.safeAreaInsets.bottom
        let keyboardTop = keyboardFrame.minY
        let fieldBottom = focusedField.convert(focusedField.frame, to: view).maxY
        let yOffset = (scrollView?.contentOffset.y ?? 0) + max(0, fieldBottom - keyboardTop + 16)
        
        if keyboardHeigh > 100 {
            self.constraint?.constant = keyboardHeigh
            self.scrollView?.setContentOffset(CGPoint(x: 0, y: yOffset), animated: true)
        } else {
            self.constraint?.constant = defaultConstant ?? 0
        }
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}
