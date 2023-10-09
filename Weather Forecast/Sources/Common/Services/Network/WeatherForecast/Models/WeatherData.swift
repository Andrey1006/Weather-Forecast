//
//  WeatherDataRemoteModel.swift
//  Weather ForecastRemoteModel
//
//  Created by Андрей Сторожко on 20.09.2023.
//

import Foundation

struct WeatherForecastApiResponse: Decodable {
    var location: LocationRemoteModel
    var current: CurrentWeatherForecastRemoteModel
    var forecast: ForecastRemoteModel
}

struct LocationRemoteModel: Decodable {
    var name: String
    var localtime: String
}

struct CurrentWeatherForecastRemoteModel: Decodable {
    var temperature: Double
    var uVIndex: Double
    var feelslike: Double
    var precipitationMm: Double
    var pressureMb: Double
    var visibilityKm: Double
    var windKph: Double
    var condition: WeatherConditionRemoteModel
    
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

struct ForecastRemoteModel: Decodable {
    var forecastday: [FullDayWeatherForecastRemoteModel]
}

struct FullDayWeatherForecastRemoteModel: Decodable {
    var date: String
    var day: DayWeatherForecastRemoteModel
    var astro: AstroRemoteModel
    var hour: [HourWeatherForecaseRemoteModel]
}

struct DayWeatherForecastRemoteModel: Decodable {
    var maxTempereture: Double
    var minTempereture: Double
    var condition: WeatherConditionRemoteModel
    var uVIndex: Double
    
    private enum CodingKeys: String, CodingKey {
        case maxTempereture = "maxtemp_c"
        case minTempereture = "mintemp_c"
        case condition
        case uVIndex = "uv"
    }
}

struct WeatherConditionRemoteModel: Decodable {
    var text: String
    var icon: String
}

struct AstroRemoteModel: Decodable {
    var sunrise: String
    var sunset: String
    var moonrise: String
    var moonset: String
}

struct HourWeatherForecaseRemoteModel: Decodable {
    var time: String
    var temperature: Double
    var condition: WeatherConditionRemoteModel
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


