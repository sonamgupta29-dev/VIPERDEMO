//
//  Dictionary.swift
//  DemoBasic
//
//  Created by Sonam Gupta on 12/11/2019.
//  Copyright © 2019 Sonam Gupta. All rights reserved.
//

import Foundation
public extension Dictionary where Key == String, Value == Any? {

    func urlEncodedString(base: String = "") throws -> String {

        guard self.count > 0 else { return "" } // nothing to encode

        let items: [URLQueryItem] = self.compactMap { (key,value) in

            guard let v = value else { return nil } // skip item if no value is set

            return URLQueryItem(name: key, value: String(describing: v))

        }

        var urlComponents = URLComponents(string: base)!

        urlComponents.queryItems = items

        guard let encodedString = urlComponents.url else {

            throw NetworkError.dataNotEncodable

        }

        return encodedString.absoluteString

    }

    

}
