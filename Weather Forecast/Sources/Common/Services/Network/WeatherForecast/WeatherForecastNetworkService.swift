//
//  WeatherForecastNetworkService.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 20.09.2023.
//

import Foundation
import Alamofire

final class WeatherForecastNetworkService {
    private let apiKey: String = "0b2d6edb40074e36b1595241231809"
    
    func fetchData(
        region: String,
        days: Int,
        completion: @escaping (Result<WeatherForecastDomainModel, NetworkError>) -> Void
    ) {
        AF.request("https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(region)&days=\(days)")
            .responseDecodable(of: WeatherForecastApiResponse.self) { result in
                print(result)
                switch result.result {
                case .success(let weatherData):
                    completion(.success(self.mapToDomainModel(weatherData: weatherData)))
                case .failure(let error):
                    completion(.failure(.init(underlyingError: error)))
                }
            }
    }
    
    private func mapToDomainModel(weatherData: WeatherForecastApiResponse) -> WeatherForecastDomainModel {
        return .init(
            location: .init(
                city: weatherData.location.name,
                localTime: weatherData.location.localtime
            ),
            forecast: weatherData.forecast.forecastday.map { forecastDay in
                return .init(
                    date: forecastDay.date,
                    maxTempereture: Int(forecastDay.hour.map(\.temperature).max() ?? forecastDay.day.maxTempereture),
                    minTempereture: Int(forecastDay.hour.map(\.temperature).min() ?? forecastDay.day.minTempereture),
                    sunrise: forecastDay.astro.sunrise,
                    sunset: forecastDay.astro.sunset,
                    moonrise: forecastDay.astro.moonrise,
                    moonset: forecastDay.astro.moonset,
                    icon: forecastDay.day.condition.icon,
                    hourForecast: forecastDay.hour.map { hour in
                        return .init(
                            temperature: Int(hour.temperature),
                            uVIndex: Int(hour.condition.icon) ?? 0,
                            feelslike: Int(hour.feelslike),
                            precipitationMm: Int(hour.precipitationMm),
                            pressureMb: Int(hour.pressureMb),
                            humidity: Int(weatherData.forecast.forecastday[0].day.humidity),
                            totalPrecipitation: weatherData.forecast.forecastday[0].day.totalPrecipitation,
                            visibilityKm: Int(hour.visibilityKm),
                            windKph: Int(hour.windKph),
                            windDirection: hour.windDirection,
                            time: hour.time,
                            text: hour.condition.text,
                            icon: hour.condition.icon
                        )
                    }
                )
            },
            currentHourWeather: .init(
                temperature: Int(weatherData.current.temperature),
                uVIndex: Int(weatherData.current.uVIndex),
                feelslike: Int(weatherData.current.feelslike),
                precipitationMm: Int(weatherData.current.precipitationMm),
                pressureMb: Int(weatherData.current.pressureMb),
                humidity: Int(weatherData.forecast.forecastday[0].day.humidity),
                totalPrecipitation: weatherData.forecast.forecastday[0].day.totalPrecipitation,
                visibilityKm: Int(weatherData.current.visibilityKm),
                windKph: Int(weatherData.current.windKph),
                windDirection: weatherData.current.windDirection,
                time: weatherData.location.localtime,
                text: weatherData.current.condition.text,
                icon: weatherData.current.condition.icon
            )
        )
    }
}
