//
//  FiveDayForecastViewModel.swift
//  ShopThing Weather App
//
//  Created by Dhruvil Patel on 2021-04-20.
//

import Foundation

struct FiveDayForecastViewModel {
    
    var consolidatedWeather : [ConsolidatedWeather]
    
    init(consolidatedWeather: [ConsolidatedWeather]) {
        self.consolidatedWeather = consolidatedWeather
    }
}
