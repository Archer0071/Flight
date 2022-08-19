//
//  MockService.swift
//  FlightTests
//
//  Created by ARCHER on 19/08/2022.
//

import Foundation
import Combine
import Alamofire

@testable import Flight

class MockService:ServiceProtocol {
    
    func fetchStations() -> AnyPublisher<DataResponse<Stations, NetworkError>, Never> {
        let path = Bundle.main.path(forResource: "data", ofType: "json")
        let url = URL(fileURLWithPath: path ?? "")
        return AF.request(url,
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
