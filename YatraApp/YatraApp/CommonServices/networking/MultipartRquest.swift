//
//  MultipartRquest.swift
//  GlutenDude
//
//  Created by Ghanshyam Gupta on 13/02/2020.
//  Copyright © 2020 GlutenDude. All rights reserved.
//

import Foundation
import UIKit
typealias  CompletionBlock = (_ success:Bool? , _ error:Error?)-> Void
class MultipartRquest {
    //public var jsonObject: Any?
    func updatedProfile(withPath : String, image:UIImage , data:[String:String] , _ completion: @escaping CompletionBlock)
    {
        
        guard
            let config = Bundle.main.object(forInfoDictionaryKey: "Endpoint") as? [String:Any],
            let baseURL = config["url"] as? String
            else {
                return
        }
        
        let completeUrl = baseURL + withPath
        print(completeUrl)
        let objmultipart = VMultipartImage.init(completeUrl, paramters: data, image: image, imagekey: "imageUrl", imageName: "imageUrl.jpeg")
        objmultipart.request.httpMethod = Method.PUT.rawValue
        let session = URLSession.shared
        session.dataTask(with: objmultipart.request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data , options: []) as? [String:Any],
                        let status = jsonObject["statusCode"] as? Int else {
                            return
                    }
                    print(jsonObject)
                    //check whether the server return 101 status code. 101 status code implies a successful operation
                    if (status == 200) {
                        //self.jsonObject = jsonObject["data"]
                        completion(true , nil)
                    }else{
                        if status == 404 {
                            let errorMessage = (jsonObject["status"] as? String) ?? "Unknown error was encountered."
                            completion(nil, NetworkError.serverError(reason: errorMessage))
                        }else{
                            if let networkError = NetworkError.fromStatusCode(code: status) {
                                completion(nil , networkError)
                            }else{
                                completion(nil , NetworkError.unknown)
                            }
                        }
                        
                    }
                } catch {
                    print(error)
                    completion(nil ,  NetworkError.invalidResponseFormat)
                }
            }
        }.resume()
    }
    
}


