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
            .responseDecodable(of: WeatherData.self) { result in
                print(result)
                switch result.result {
                case .success(let weatherData):
                    let weatherDomainModel = self.mapWeatherDataToDomainModel(weatherData: weatherData)
                    completion(.success(weatherDomainModel))
                case .failure(let error):
                    completion(.failure(.init(underlyingError: error)))
                }
            }
    }
    
    private func mapWeatherDataToDomainModel(weatherData: WeatherData) -> WeatherForecastDomainModel {
        let location: CityLocation = .init(
            city: weatherData.location.name,
            localTime: weatherData.location.localtime
        )
        
        var dayWeatherForecasts: [DayWeatherForecast] = []
        
        for forecastDay in weatherData.forecast.forecastday {
            var hourForecasts: [HourWeatherForecast] = []
            
            for hour in forecastDay.hour {
                hourForecasts.append(
                    .init(
                        temperature: Int(hour.temperature),
                        uVIndex: Int(hour.condition.icon) ?? 0,
                        feelslike: Int(hour.feelslike),
                        precipitationMm: Int(hour.precipitationMm),
                        pressureMb: Int(hour.pressureMb),
                        visibilityKm: Int(hour.visibilityKm),
                        windKph: Int(hour.windKph),
                        time: hour.time,
                        text: hour.condition.text,
                        icon: hour.condition.icon
                    )
                )
            }
            
            let dayWeatherForecast: DayWeatherForecast = .init(
                date: forecastDay.date,
                maxTempereture: Int(forecastDay.day.maxTempereture),
                minTempereture: Int(forecastDay.day.minTempereture),
                sunrise: forecastDay.astro.sunrise,
                sunset: forecastDay.astro.sunset,
                moonrise: forecastDay.astro.moonrise,
                moonset: forecastDay.astro.moonset,
                hourForecast: hourForecasts
            )
                        
            dayWeatherForecasts.append(dayWeatherForecast)
        }
        
        let weatherDomainModel = WeatherForecastDomainModel(
            location: location,
            forecast: dayWeatherForecasts,
            currentHourWeather: .init(
                temperature: Int(weatherData.current.temperature),
                uVIndex: Int(weatherData.current.uVIndex),
                feelslike: Int(weatherData.current.feelslike),
                precipitationMm: Int(weatherData.current.precipitationMm),
                pressureMb: Int(weatherData.current.pressureMb),
                visibilityKm: Int(weatherData.current.visibilityKm),
                windKph: Int(weatherData.current.windKph),
                time: weatherData.location.localtime,
                text: weatherData.current.condition.text,
                icon: weatherData.current.condition.icon
            )
        )
        
        return weatherDomainModel
    }
}
