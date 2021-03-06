//
//  ConsolidatedWeatherViewModel.swift
//  ShopThing Weather App
//
//  Created by Dhruvil Patel on 2021-04-20.
//

import Foundation


struct ConsolidatedWeatherViewModel {
    
    var consolidatedWeather : ConsolidatedWeather
    
    init(consolidatedWeather: ConsolidatedWeather) {
        self.consolidatedWeather = consolidatedWeather
    }
    
        var date: String {
            return formatDate(stringDate: self.consolidatedWeather.applicable_date)
        }
    
        var minTemp: String {
            return formatTemp(self.consolidatedWeather.min_temp)
        }
    
        var maxTemp: String {
            return formatTemp(self.consolidatedWeather.max_temp)
        }
    
        var weatherState: String {
            return self.consolidatedWeather.weather_state_name
        }
    
        var imageAbbURL: String {
            return "https://www.metaweather.com/static/img/weather/png/\(self.consolidatedWeather.weather_state_abbr).png"
        }
    
    
        func formatTemp(_ temp: Double) -> String {
            return String(format: "%.0f", temp)
        }
    
    func formatDate(stringDate: String) -> String {
        
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
}
