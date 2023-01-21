//
//  UIApplication + .swift
//  10 Food
//
//  Created by Yevhen Biiak on 18.01.2023.
//

import UIKit

extension UIApplication {
    var statusBarHeight: CGFloat? {
        return scene?.statusBarManager?.statusBarFrame.height
    }
    
    var scene: UIWindowScene? {
        UIApplication.shared.connectedScenes.first as? UIWindowScene
    }
    
    var screen: UIScreen? {
        scene?.screen
    }
    
    var window: UIWindow? {
        scene?.windows.filter { $0.isKeyWindow }.first
    }
}
