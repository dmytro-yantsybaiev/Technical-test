//
//  TypeIdentifiable.swift
//  Technical-test
//
//  Created by Dmytro Yantsybaiev on 26.01.2023.
//

import UIKit

public protocol TypeIdentifiable {

    static var typeName: String { get }
    static var nibName: String { get }
    static var nib: UINib { get }
}

public extension TypeIdentifiable {

    static var typeName: String {
        String(describing: self)
    }

    static var nibName: String {
        String(describing: self)
    }

    static var nib: UINib {
        UINib(nibName: self.typeName, bundle: nil)
    }
}
