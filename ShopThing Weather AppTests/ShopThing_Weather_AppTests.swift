//
//  ShopThing_Weather_AppTests.swift
//  ShopThing Weather AppTests
//
//  Created by Dhruvil Patel on 2021-04-20.
//

import XCTest
@testable import ShopThing_Weather_App

class ShopThing_Weather_AppTests: XCTestCase {
    
    let consolidatedWeather = ConsolidatedWeather(id: 0, weather_state_name: "Heavy Rain", weather_state_abbr: "hr", applicable_date: "2021-04-20", min_temp: 24.903, max_temp: 33.34, the_temp: 27.88)
    
   

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Testing WeatherViewModel
    func testWeatherViewModel() {
        let weather = Weather(consolidated_weather: [consolidatedWeather], title: "Toronto", woeid: 3453233)
        let weatherViewModel = WeatherViewModel(weather: weather)
        
        XCTAssertEqual(weather.title, weatherViewModel.cityName)
        XCTAssertEqual(checkFormattedTemp(temp: weather.consolidated_weather[0].the_temp), weatherViewModel.currentTemp)
        XCTAssertEqual(checkFormattedTemp(temp: weather.consolidated_weather[0].max_temp), weatherViewModel.maxTemp)
        XCTAssertEqual(checkFormattedTemp(temp: weather.consolidated_weather[0].min_temp), weatherViewModel.minTemp)
        XCTAssertEqual(checkWeatherStateAbbrURL(weatherStateAbbr: weather.consolidated_weather[0].weather_state_abbr), weatherViewModel.imageAbbURL)
        XCTAssertEqual(weather.consolidated_weather[0].weather_state_name, weatherViewModel.weatherState)
    }
    
    /// Testing ConsolidatedWeatherViewModel
    func testConsolidatedWeatherViewModel(){
        
        let consolidatedWeatherViewModel = ConsolidatedWeatherViewModel(consolidatedWeather: consolidatedWeather)
        XCTAssertEqual(checkFormattedDate(stringDate: consolidatedWeather.applicable_date), consolidatedWeatherViewModel.date)
        XCTAssertEqual(checkFormattedTemp(temp: consolidatedWeather.min_temp), consolidatedWeatherViewModel.minTemp)
        XCTAssertEqual(checkFormattedTemp(temp: consolidatedWeather.max_temp), consolidatedWeatherViewModel.maxTemp)
        XCTAssertEqual(checkWeatherStateAbbrURL(weatherStateAbbr: consolidatedWeather.weather_state_abbr), consolidatedWeatherViewModel.imageAbbURL)
        XCTAssertEqual(consolidatedWeather.weather_state_name, consolidatedWeatherViewModel.weatherState)
        
    }
    
    
    func checkFormattedDate(stringDate: String) -> String {
        
        let dateFormatter = DateFormatter()
        
        /// Get date in "2021-04-20" format
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: stringDate){
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            
            /// Convert date to Tuesday, Apr 20, 2021 format
            dateFormatter.dateFormat = "EEEE, MMM dd,yyyy"
            
            if let finalDate = calendar.date(from: components){
                return "\(dateFormatter.string(from: finalDate))"
            }
        }
        return "nil"
    }
    
    func checkFormattedTemp(temp: Double) -> String {
        return String(format: "%.0f", temp)
    }
    
    func checkWeatherStateAbbrURL(weatherStateAbbr: String) -> String {
        return "https://www.metaweather.com/static/img/weather/png/\(weatherStateAbbr).png"
    }

}
