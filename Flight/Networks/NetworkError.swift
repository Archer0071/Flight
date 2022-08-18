//
//  NetworkError.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//
import Foundation
import Alamofire

struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}
