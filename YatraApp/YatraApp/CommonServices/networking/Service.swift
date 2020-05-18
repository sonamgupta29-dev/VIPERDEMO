//
//  Service.swift
//  ProgressCharter
//
//  Created by Sonam Gupta on 05/08/19.
//  Copyright © 2019 nmg. All rights reserved.
//

import Foundation

public class Service: ServiceProtocol {
    func execute(_ request: RequestProtocol, retry: Int?, _ completion: @escaping completionBlock) {
        var urlRequest: URLRequest!
        
        do {
            urlRequest = try request.urlRequest(in: self)
        }catch (let error) {
            completion(.failure(.other(reason: error)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.other(reason: error!)))
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse
                else{
                    completion(.failure(.noStatusCodeFound))
                    return
            }
            
            
            let response = Response(networkResponse: httpResponse,
                                    request: request,
                                    data: data)
            completion(.success(response))
        }
        
        task.resume()
    }
    
    
    
    public var configuration: ServiceConfig
    public var headers: [String : String]
    
    public required init(_ configuration: ServiceConfig) {
        self.configuration = configuration
        self.headers = configuration.headers
    }
    
    
}
