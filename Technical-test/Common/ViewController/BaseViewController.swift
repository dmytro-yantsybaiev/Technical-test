//
//  BaseViewController.swift
//  Technical-test
//
//  Created by Dmytro Yantsybaiev on 29.01.2023.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.backgroundColor = .systemBackground
        navigationBar.isTranslucent = true
    }
}
