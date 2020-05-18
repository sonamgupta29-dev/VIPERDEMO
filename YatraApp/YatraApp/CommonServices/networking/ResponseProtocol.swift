//
//  ResponseProtocol.swift
//  ProgressCharter
//
//  Created by Sonam Gupta on 05/08/19.
//  Copyright © 2019 nmg. All rights reserved.
//

import Foundation

protocol ResponseProtocol {
    var request: RequestProtocol { get set }
    var type: ResponseType { get }
    var httpResponse: HTTPURLResponse { get }
    var httpStatusCode: Int { get }
    var data: Data? { get }
    var jsonObject: Any? { get set }
    func toJSON() throws -> [String:Any]
    func toString() -> String?
}

