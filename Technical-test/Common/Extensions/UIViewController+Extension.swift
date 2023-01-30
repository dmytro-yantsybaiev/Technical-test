//
//  UIViewController+Extension.swift
//  Technical-test
//
//  Created by Dmytro Yantsybaiev on 29.01.2023.
//

import UIKit

extension UIViewController {

    func presentAlert(alert: UIAlertController,
                      needCloseWhenTapOutside: Bool = false,
                      animated: Bool = true) {

        present(alert, animated: animated) {
            if needCloseWhenTapOutside {
                alert.view.superview?.isUserInteractionEnabled = true
                alert.view.superview?.addGestureRecognizer(
                    UITapGestureRecognizer(target: self,
                                           action: #selector(self.dismissAlertOnTapOutside)))
            }
        }
    }

    @objc func dismissAlertOnTapOutside() {
        self.dismiss(animated: true)
    }
}
