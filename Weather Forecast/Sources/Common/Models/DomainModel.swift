//
//  DomainModel.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 02.10.2023.
//

import Foundation

struct WeatherForecastDomainModel {
    let location: CityLocation
    var forecast: [DayWeatherForecast]
    var currentHourWeather: HourWeatherForecast
}

struct CityLocation {
    var city: String
    var localTime: String
}


struct DayWeatherForecast {
    var date: String
    var maxTempereture: Int
    var minTempereture: Int
    var sunrise: String
    var sunset: String
    var moonrise: String
    var moonset: String

    var hourForecast: [HourWeatherForecast]
}

struct HourWeatherForecast {
    var temperature: Int
    var uVIndex: Int
    var feelslike: Int
    var precipitationMm: Int
    var pressureMb: Int
    var visibilityKm: Int
    var windKph: Int
    var time: String
    var text: String
    var icon: String
}
