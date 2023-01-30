//
//  APIClient.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation
import Combine

final class APIClient {

    func fetchQuotes() -> AnyPublisher<[Quote], Error> {
        URLSession.shared
            .dataTaskPublisher(for: Constants.URLs.quotes)
            .tryMap { data, response in
                guard 200...299 ~= response.code else {
                    throw NetworkError.badServerResponse
                }
                return try JSONDecoder().decode([Quote].self, from: data)
            }
            .eraseToAnyPublisher()
    }
}
