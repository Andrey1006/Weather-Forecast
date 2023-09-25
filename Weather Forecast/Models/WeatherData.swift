//
//  WeatherData.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 20.09.2023.
//

import Foundation

struct WeatherData: Codable {
    var location: Location
    var current: Current
    var forecast: Forecast
}

struct Location: Codable {
    var name: String
    var region: String
    var country: String
    var lat: Double
    var lon: Double
    var tz_id: String
    var localtime_epoch: Double
    var localtime: String
}

struct Current: Codable {
    var temp_c: Double
    var condition: Condition
    var wind_kph: Double
    var humidity: Double
}

struct Condition: Codable {
    var text: String
    var icon: String
}

struct Forecast: Codable {
    var forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    var date: String
    var day: Day
}

struct Day: Codable {
    var maxtemp_c: Double
    var mintemp_c: Double
    var avgtemp_c: Double
    var maxwind_kph: Double
    var totalprecip_mm: Double
    var condition: Condition
    var uv: Double
}


