//
//  DataOperation.swift
//  ProgressCharter
//
//  Created by Sonam Gupta on 05/08/19.
//  Copyright © 2019 nmg. All rights reserved.
//

import Foundation

open class DataOperation<T: Decodable>: DataOperationProtocol {
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
    
    func execute(service: ServiceProtocol = Service(ServiceConfig.appConfig()!)  , retry: Int?,
                 completion: @escaping (Result<[T]?, NetworkError>) -> ()) {
        service.execute(request, retry: retry) { (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let response):
                    self.printCall(withData: response.data)
                    switch(response.type) {
                    case .error(let error):
                        switch error {
                        case .sessionExpired:
                            //user's session has expired. Log him out
                            self.logout()
                        default:
                            break
                        }
                        print("****Server Error*****\n\n\(error)")
                        completion(.failure(error))
                    case .success(_ ):
                        guard let jsonObject = response.jsonObject else {
                            completion(.success(nil))
                            return
                        }
                        
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                            let objectModel = try JSONDecoder().decode([T].self, from: jsonData)
                            completion(.success(objectModel))
                        }catch(let error) {
                            print("****TypeCasting Error*****\n\n\(error)")
                            completion(.failure(.other(reason: error)))
                        }
                        
                    case .noResponse:
                        print("****Unknown Error*****\n")
                        completion(.failure(.unknown))
                    }
                    break
                case .failure(let error):
                    print("****Server Error*****\n\n\(error)")
                    completion(.failure(error))
                }
            }
            
        }
    }
}



