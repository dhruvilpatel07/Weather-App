//
//  Weather.swift
//  ShopThing Weather App
//
//  Created by Dhruvil Patel on 2021-04-20.
//

import Foundation

struct Weather: Codable {
    let consolidated_weather: [ConsolidatedWeather]
    let title: String
    let woeid: Int
}

struct ConsolidatedWeather: Codable {
    let id: Int
    let weather_state_name: String
    let weather_state_abbr: String
    let applicable_date: String
    let min_temp: Double
    let max_temp: Double
    let the_temp: Double
}
