//
//  ViewModelType.swift
//  Technical-test
//
//  Created by Dmytro Yantsybaiev on 28.01.2023.
//

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
