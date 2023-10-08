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
    var localtime: String
}

struct Current: Codable {
    var temperature: Double
    var uVIndex: Double
    var feelslike: Double
    var precipitationMm: Double
    var pressureMb: Double
    var visibilityKm: Double
    var windKph: Double
    var condition: Condition
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp_c"
        case uVIndex = "uv"
        case feelslike = "feelslike_c"
        case precipitationMm = "precip_mm"
        case pressureMb = "pressure_mb"
        case visibilityKm = "vis_km"
        case windKph = "wind_kph"
        case condition
    }
}

struct Forecast: Codable {
    var forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    var date: String
    var day: Day
    var astro: Astro
    var hour: [Hour]
}

struct Day: Codable {
    var maxTempereture: Double
    var minTempereture: Double
    var condition: Condition
    var uVIndex: Double
    
    private enum CodingKeys: String, CodingKey {
        case maxTempereture = "maxtemp_c"
        case minTempereture = "mintemp_c"
        case condition
        case uVIndex = "uv"
    }
}

struct Condition: Codable {
    var text: String
    var icon: String
}

struct Astro: Codable {
    var sunrise: String
    var sunset: String
    var moonrise: String
    var moonset: String
}

struct Hour: Codable {
    var time: String
    var temperature: Double
    var condition: Condition
    var feelslike: Double
    var windKph: Double
    var uVIndex: Double
    var precipitationMm: Double
    var pressureMb: Double
    var visibilityKm: Double
    
    private enum CodingKeys: String, CodingKey {
        case time
        case temperature = "temp_c"
        case condition
        case feelslike = "feelslike_c"
        case windKph = "wind_kph"
        case uVIndex = "uv"
        case precipitationMm = "precip_mm"
        case pressureMb = "pressure_mb"
        case visibilityKm = "vis_km"
    }
}


