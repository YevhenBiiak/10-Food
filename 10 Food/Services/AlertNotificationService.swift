//
//  AlertNotificationService.swift
//  10 Food
//
//  Created by Yevhen Biiak on 21.01.2023.
//

import UIKit

class AlertNotificationService: NotificationService {
    
    func notify(phone: String, withTitle title: String, message: String) {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.showNotificationAler(title: title, message: message)
        }
    }
}

private extension AlertNotificationService {
    
    func showNotificationAler(title: String, message: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let messageFont = [NSAttributedString.Key.font: UIFont.monospacedSystemFont(ofSize: 30, weight: .bold)]
        let messageAttrString = NSMutableAttributedString(string: "\n\(message)", attributes: messageFont)
        alert.setValue(messageAttrString, forKey: "attributedMessage")
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        UIApplication.shared.window?.rootViewController?.present(alert, animated: true)
    }
}
