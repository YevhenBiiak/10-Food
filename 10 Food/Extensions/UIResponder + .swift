//
//  UIResponder + .swift
//  10 Food
//
//  Created by Yevhen Biiak on 21.01.2023.
//

import UIKit

extension UIResponder {
    
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    // Finds the current first responder
    /// - Returns: the current UIResponder if it exists
    static func firstResponder () -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc private func _trap() {
        Static.responder = self
    }
}
