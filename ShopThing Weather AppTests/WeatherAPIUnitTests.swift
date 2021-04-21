//
//  WeatherAPIUnitTests.swift
//  ShopThing Weather AppTests
//
//  Created by Dhruvil Patel on 2021-04-20.
//

import XCTest
@testable import ShopThing_Weather_App

class WeatherAPIUnitTests: XCTestCase {
    
    /// Testing whether location api is giving valid woeid back or not
    func testWeatherAPIGetCityLocationId(){
        let weatherAPI = WeatherAPI()
        let location = Location(title: "Toronto", location_type: "City", woeid: 4118, latt_long: "43.648560,-79.385368")
        let testURL = "https://www.metaweather.com/api/location/search/?query=toront"
        let expectation = self.expectation(description: "Valid_City_Id")
        weatherAPI.getCityLocationId(urlString: testURL) { (result) in
            switch result {
                case .success(let cityId):
                    XCTAssertEqual(location.woeid, cityId)
                    expectation.fulfill()
            case .failure: break
                
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        
    }

}
