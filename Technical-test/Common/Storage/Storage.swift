//
//  Storage.swift
//  Technical-test
//
//  Created by Dmytro Yantsybaiev on 29.01.2023.
//

final class Storage {

    private enum Keys: String {
        case market
    }

    static let shared = Storage()

    private let keychain = Keychain(account: "com.technical-test")

    var market: Market? {
        get {
            return keychain.load(key: Keys.market.rawValue)
        }
        set {
            if let market = newValue {
                keychain.save(market, key: Keys.market.rawValue)
            }
        }
    }

    private init() {}
}
