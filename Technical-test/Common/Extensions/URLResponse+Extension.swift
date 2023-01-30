//
//  URLResponse+Extension.swift
//  Technical-test
//
//  Created by Dmytro Yantsybaiev on 26.01.2023.
//

import Foundation

extension URLResponse {

    var code: Int {
        (self as! HTTPURLResponse).statusCode
    }
}
