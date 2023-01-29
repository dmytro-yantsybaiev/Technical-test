//
//  Quote.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

struct Quote: Codable {

    private enum CodingKeys: CodingKey {
        case symbol
        case name
        case currency
        case readableLastChangePercent
        case last
        case variationColor
    }

    let symbol: String?
    let name: String?
    let currency: String?
    let readableLastChangePercent: String?
    let last: String?
    let variationColor: String?
    var myMarket: Market?
}

extension Quote {

    var lastChangeColor: UIColor {
        switch variationColor {
        case "red": return .red
        case "green": return .green
        default: return .label
        }
    }
}
