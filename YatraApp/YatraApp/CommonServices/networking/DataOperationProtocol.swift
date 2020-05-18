//
//  OperationProtocol.swift
//  ProgressCharter
//
//  Created by Sonam Gupta on 05/08/19.
//  Copyright © 2019 nmg. All rights reserved.
//

import Foundation

protocol DataOperationProtocol {
    associatedtype T
    
    var request: RequestProtocol! { get set }
    
    func execute(service: ServiceProtocol,
                 retry: Int?,
                 completion: @escaping (Result<T?, NetworkError>) -> ())
}

extension DataOperationProtocol {
    func debugPrint() {
        let requestMethod = request.method
        let url = try! request.url(in: Service(ServiceConfig.appConfig()!))
        let requestBody = String(data: request.body ?? Data(), encoding: .utf8)
        
        print("URL: \(url) \nMethod: \(requestMethod)\nbody:\(requestBody ?? "")\nHeaders:\(request.headers)")
    }
    
    func logout() {
//        Disk.clear()
//        //TODO:- Execute logout service when its ready
//        Router.appRootNavigator?.presentedViewController?.dismiss(animated: true, completion: nil)
//        Router.appRootNavigator?.viewControllers = [LoginRouter.createModule()]
    }
}
