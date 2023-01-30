//
//  QuotesListViewModel.swift
//  Technical-test
//
//  Created by Dmytro Yantsybaiev on 27.01.2023.
//

import Foundation
import Combine

final class QuotesListViewModel: ViewModelType {

    struct Input {
        let fetchQuotes: PassthroughSubject<Void, Never>
    }

    struct Output {
        let quotes: AnyPublisher<[Quote], Error>
    }

    private let apiClient: APIClient = APIClient()

    func transform(input: Input) -> Output {

        let quotes = input.fetchQuotes
            .flatMap {
                self.apiClient.fetchQuotes()
            }
            .eraseToAnyPublisher()

        return Output(quotes: quotes)
    }
}
