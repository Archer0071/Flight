//
//  StationsViewModel_Test.swift
//  FlightTests
//
//  Created by ARCHER on 19/08/2022.
//

import XCTest
@testable import Flight

class StationsViewModel_Test: XCTestCase {

    var mockService:MockService!
    var viewModel:StationsViewModel!
    
    
    var stations = [Station(code: "ABC", name: "ABC", alternateName: "ABC", alias: nil, countryCode: nil, countryName: "ABC", countryGroupCode: nil, countryGroupName: nil, timeZoneCode: nil, latitude: nil, longitude: nil, mobileBoardingPass: true, markets: [Market(code: "ABC", group: "ABC", stops: nil, onlyConnecting: nil, pendingApproval: nil, onlyPrintedBoardingPass: nil)], tripCardImageURL: nil, airportShopping: false)]
    
    
    override func setUp() {
        mockService = MockService()
        viewModel = StationsViewModel(dataService: mockService)
       
    }
    func testApi_response_Alert_false(){
        XCTAssert(!viewModel.showAlert)
    }
    
    func testApi_response_list_loading_Error(){
        XCTAssertEqual("", viewModel.listLoadingError)
    }
    
    func testApi_Data_Not_Empty(){
        viewModel.stations = stations
        XCTAssert(!(viewModel.stations.isEmpty))
    }
    func testApi_Data_Empty(){
        XCTAssert((viewModel.stations.isEmpty))
    }
    
    func testApi_response_total_count_1(){
        viewModel.stations = stations
        XCTAssertEqual(1, viewModel.numberOfStations())
    }
    func testApi_response_station_getStation_code(){
        viewModel.stations = stations
        XCTAssertEqual("ABC",viewModel.stationAt(indexPath: IndexPath(row: 0, section: 0)).code)
    }
   

}
