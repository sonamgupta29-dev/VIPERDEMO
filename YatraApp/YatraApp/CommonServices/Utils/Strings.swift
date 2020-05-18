//
//  Strings.swift
//  DemoBasic
//
//  Created by Sonam Gupta on 12/11/2019.
//  Copyright © 2019 Sonam Gupta. All rights reserved.
//

import Foundation
enum Strings: String {
//MARK:- Errors
   case internalServerError
   case badRequest
   case unauthorized
   case forbidden
   case resourceNotFound = "Sign in Failure. Please verify email or password."
   case methodNotAllowed
   case uprocessableEntity
   case dataNotEncodable
   case invalidURL
   case otherError
   case noStatusCodeFound
   case sessionExpired
   case unknown
   case invalidResponseFormat = "Server not responding. Please try after some time"
   case apiException
   case tryAgainTitle
   case alertOk = "OK"
   case generalErrorTitle
   case signupFailure = "Sign Up Failure. EmailId already exists."
 public var localizedValue: String {
     return rawValue.localized
 }
}
