//
//  ServiceProtocol.swift
//  ProgressCharter
//
//  Created by Sonam Gupta on 05/08/19.
//  Copyright © 2019 nmg. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    typealias completionBlock = (Result<ResponseProtocol, NetworkError>) -> ()
    var configuration: ServiceConfig { get }
    var headers: [String:String] { get }
    init(_ configuration: ServiceConfig)
    func execute(_ request: RequestProtocol, retry: Int?, _ completion: @escaping completionBlock)
}
