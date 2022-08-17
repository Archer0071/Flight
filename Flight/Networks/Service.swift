//
//  Service.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import Foundation
import Combine
import Alamofire



class Service:ServiceProtocol {
    
    func fetchStations() -> AnyPublisher<DataResponse<Stations, NetworkError>, Never> {
        return AF.request("https://mobile-testassets-dev.s3.eu-west-1.amazonaws.com/stations.json",
                          method: .get)
            .validate()
            .publishDecodable(type: Stations.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    
                    return NetworkError(initialError: error, backendError: backendError)
                }
                
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
}
