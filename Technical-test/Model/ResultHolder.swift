//
//  ResultHolder.swift
//  Technical-test
//
//  Created by Dmytro Yantsybaiev on 27.01.2023.
//

actor ResultHolder<T, U> where T: Any, U: Error {

    private var result: Result<T, U>?

    func put(_ result: Result<T, U>) {
        self.result = result
    }

    func takeResult() -> Result<T, U>? {
        result
    }
}
