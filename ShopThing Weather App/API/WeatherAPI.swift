//
//  WeatherAPI.swift
//  ShopThing Weather App
//
//  Created by Dhruvil Patel on 2021-04-20.
//

import Foundation

protocol WeatherAPIDelegate {
    /// Calls this method if weather data is found and updated
    /// - Parameters:
    ///   - weatherAPI: Passes WeatherAPI
    ///   - weatherViewModel: Passes WeatherViewModel to set properties
    func didUpdateWeather(_ weatherAPI: WeatherAPI, weatherViewModel: WeatherViewModel)
    /// Calls this method if weather data is not found
    /// - Parameters:
    ///   - error: Passes Error to print
    ///   - errorMessage: Passes customizable error message to display as alert action sheet
    func didFailWithError(error: Error, errorMessage: String)
}


class WeatherAPI {
    
    var delegate: WeatherAPIDelegate?
    
    /// Fetches weather from https://www.metaweather.com/api/
    /// - Parameter cityName: City name passed by user through text field
    func fetchWeather(cityName: String) {
        let weatherURL = "https://www.metaweather.com/api/location/"
        let searchCityLocationURL = "https://www.metaweather.com/api/location/search/?query=\(cityName)"
        
        getCityLocationId(urlString: searchCityLocationURL) { (id) in
            
            switch id {
                case .success(let cityId):
                    if let url = URL(string: "\(weatherURL)\(cityId)") {
                        let session = URLSession(configuration: .default)
                        let task = session.dataTask(with: url) { (data, response, error) in
                            
                            if error != nil{
                                self.delegate?.didFailWithError(error: error!, errorMessage: "Invalid City")
                                return
                            }
                            
                            if let safeData = data {
                                if let weather = self.parseJSON(safeData) {
                                    self.delegate?.didUpdateWeather(self, weatherViewModel: weather)
                                }
                            }
                        }
                        task.resume()
                    }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// Passes city woeid after fetching location data
    /// - Parameters:
    ///   - urlString: url from data will be fetch
    ///   - completion: It will return city woeid upon successful url session or will return error upon failure
    func getCityLocationId(urlString : String , completion: @escaping (Result<Int, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let safeData = data {
                    if let locationId = self.parseJSONForCityId(safeData) {
                        completion(.success(locationId))
                    }
                }else{
                    fatalError("Data can not be found")
                }
            }
            
            task.resume()
        }
    }
    
    /// Decoding data passed by url session to Location data
    /// - Parameter locationData: Passed data from url session
    /// - Returns: Returns location woeid
    func parseJSONForCityId(_ locationData: Data) -> Int? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode([Location]?.self, from: locationData)
            if let safeData = decodedData, !safeData.isEmpty {
                return safeData[0].woeid
            }else {
                return nil
            }
            
        } catch {
            self.delegate?.didFailWithError(error: error, errorMessage: "Invalid City")
            return nil
        }
    }
    
    /// Decoding data passed by url session to Weathet data
    /// - Parameter weatherData: Data passed by url session
    /// - Returns: Returns WeatherViewModel
    func parseJSON(_ weatherData: Data) -> WeatherViewModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(Weather.self, from: weatherData)
            let weather = WeatherViewModel(weather: decodedData)
            return weather
            
        } catch {
            self.delegate?.didFailWithError(error: error, errorMessage: "Invalid City")
            return nil
        }
    }
}
