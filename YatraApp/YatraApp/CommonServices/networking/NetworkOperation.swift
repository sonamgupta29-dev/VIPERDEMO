//
//  NetworkOperation.swift
//  ProgressCharter
//
//  Created by Sonam Gupta on 06/08/19.
//  Copyright © 2019 nmg. All rights reserved.
//

import Foundation

open class JSONOperation: JSONOperationProtocol {
    var request: RequestProtocol!
    
    init() { }
    
    private func printCall(withData data: Data?) {
        print("\n*******Call Information******\n")
        print(debugPrint())
        if data != nil, let dataString = String(data: data!, encoding: .utf8) {
            print("\n********Response*********\n")
            print(dataString)
        }
    }
    
    func execute(service: ServiceProtocol = Service(ServiceConfig.appConfig()!) , retry: Int?, completion: @escaping (Result<Bool, NetworkError>) -> ()) {
        service.execute(request, retry: retry) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.printCall(withData: response.data)
                    switch(response.type) {
                    case .error( let error):
                        switch error {
                        case .sessionExpired:
                            self.logout()
                        default:
                            break
                        }
                        print("****Server Error*****\n\n\(error)")
                        completion(.failure(error))
                    case .noResponse:
                        completion(.failure(.unknown))
                    case .success(_):
                        completion(.success(true))
                    }
                    
                case .failure(let error):
                     print("****Server Error*****\n\n\(error)")
                    completion(.failure(error))
                }
            }
            
        }
    }
    
    
}
