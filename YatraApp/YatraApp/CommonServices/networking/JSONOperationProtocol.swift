//
//  JSONOperationProtocol.swift
//  ProgressCharter
//
//  Created by Sonam Gupta on 06/08/19.
//  Copyright © 2019 nmg. All rights reserved.
//

import Foundation
import UIKit
protocol JSONOperationProtocol {
    var request: RequestProtocol! { get set}
    func execute(service: ServiceProtocol,
                 retry: Int?,
                 completion: @escaping(Result<Bool, NetworkError>) -> ())
}

extension JSONOperationProtocol {
    func debugPrint() {
        let requestMethod = request.method
        let url = try! request.url(in: Service(ServiceConfig.appConfig()!))
        let requestBody = String(data: request.body ?? Data(), encoding: .utf8)
        print("URL: \(url) \nMethod: \(requestMethod)\nbody:\(requestBody ?? "")\nHeaders:\(request.headers)")
    }
    
    func logout() {
       
       
    }
}
