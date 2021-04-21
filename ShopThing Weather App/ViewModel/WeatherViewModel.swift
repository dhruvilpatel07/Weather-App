//
//  WeatherViewModel.swift
//  ShopThing Weather App
//
//  Created by Dhruvil Patel on 2021-04-20.
//

import Foundation

struct WeatherViewModel {
    var weather: Weather

    init(weather: Weather) {
        self.weather = weather
    }
    
    var cityName: String {
        return self.weather.title
    }
    
    var currentTemp: String {
        return String(format: "%.0f", self.weather.consolidated_weather[0].the_temp)
    }
    
    var imageAbbURL: String {
        return "https://www.metaweather.com/static/img/weather/png/\(self.weather.consolidated_weather[0].weather_state_abbr).png"
    }
    
    var weatherState: String {
        return self.weather.consolidated_weather[0].weather_state_name
    }
    
    var maxTemp: String {
        return String(format: "%.0f", self.weather.consolidated_weather[0].max_temp)
    }
    
    var minTemp: String {
        return String(format: "%.0f", self.weather.consolidated_weather[0].min_temp)
    }

}
