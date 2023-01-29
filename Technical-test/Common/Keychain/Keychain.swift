//
//  Keychain.swift
//  Technical-test
//
//  Created by Dmytro Yantsybaiev on 29.01.2023.
//

import Foundation

final class Keychain {

    private let domain: String

    init(account domain: String) {
        self.domain = domain
    }

    func save<T: Codable>(_ item: T, key: String) {
        do {
            let data = try JSONEncoder().encode(item)
            let query = [
                kSecValueData: data,
                kSecAttrService: key,
                kSecAttrAccount: domain,
                kSecClass: kSecClassGenericPassword
            ] as CFDictionary
            let status = SecItemAdd(query, nil)

            if status == errSecDuplicateItem {
                let query = [
                    kSecAttrService: key,
                    kSecAttrAccount: domain,
                    kSecClass: kSecClassGenericPassword,
                ] as CFDictionary
                let attributesToUpdate = [kSecValueData: data] as CFDictionary

                SecItemUpdate(query, attributesToUpdate)
            }
        } catch {
            assertionFailure("Fail to encode item into Keychain: \(error)")
        }
    }

    func load<T: Codable>(key: String) -> T? {
        let query = [
            kSecAttrService: key,
            kSecAttrAccount: domain,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        var result: AnyObject?

        SecItemCopyMatching(query, &result)

        guard let data = result as? Data else {
            return nil
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            assertionFailure("Fail to decode item from Keychain: \(error)")
            return nil
        }
    }

    func delete(key: String) {
        let query = [
            kSecAttrService: key,
            kSecAttrAccount: domain,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary

        SecItemDelete(query)
    }
}
