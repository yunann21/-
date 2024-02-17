//
//  UIViewController + Alert.swift
//  Должник
//
//  Created by Anna Ablogina on 16.02.2024.
//

import UIKit

extension UIViewController {
    func showAlert (withTitle title: String, andMessage message: String, completion: (() -> Void)? = nil ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in 
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}
