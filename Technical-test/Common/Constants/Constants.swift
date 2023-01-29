//
//  Constants.swift
//  Technical-test
//
//  Created by Dmytro Yantsybaiev on 27.01.2023.
//

import Foundation

struct Constants {

    struct URLs {
        static let quotes = URL(string: "https://www.swissquote.ch/mobile/iphone/Quote.action?formattedList&formatNumbers=true&listType=SMI&addServices=true&updateCounter=true&&s=smi&s=$smi&lastTime=0&&api=2&framework=6.1.1&format=json&locale=en&mobile=iphone&language=en&version=80200.0&formatNumbers=true&mid=5862297638228606086&wl=sq")!
    }

    struct ImageNames {
        static let favorite = "favorite"
        static let noFavorite = "no-favorite"
    }

    struct Keys {
        static let market = (service: "favorite-quotes-names", account: "market")
    }
}
