//
//  Publisher+Extension.swift
//  Technical-test
//
//  Created by Dmytro Yantsybaiev on 28.01.2023.
//

import Combine

extension Publisher {

    func sink(result: @escaping (Result<Self.Output, Self.Failure>) -> Void) -> AnyCancellable {
        sink { completion in
            switch completion {
            case .failure(let error): result(.failure(error))
            default: break
            }
        } receiveValue: { value in
            result(.success(value))
        }
    }
}
