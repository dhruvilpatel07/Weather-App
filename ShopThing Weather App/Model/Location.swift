//
//  Location.swift
//  ShopThing Weather App
//
//  Created by Dhruvil Patel on 2021-04-20.
//

import Foundation

struct Location: Decodable {
    let title: String
    let location_type: String
    let woeid: Int
    let latt_long: String
}
