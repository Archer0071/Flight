//
//  ServiceProtocol.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import Foundation
import Combine
import Alamofire

protocol ServiceProtocol {

    func fetchStations() -> AnyPublisher<DataResponse<Stations, NetworkError>, Never>
}
