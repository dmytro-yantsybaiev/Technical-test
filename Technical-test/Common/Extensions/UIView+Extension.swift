//
//  UIView+Extension.swift
//  Technical-test
//
//  Created by Dmytro Yantsybaiev on 26.01.2023.
//

import UIKit

extension UIView {

    func setConstraints(to view: UIView) {
        let safeArea = view.safeAreaLayoutGuide
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
}
