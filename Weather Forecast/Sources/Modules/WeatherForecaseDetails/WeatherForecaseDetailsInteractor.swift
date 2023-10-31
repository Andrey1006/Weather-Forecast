//
//  WeatherForecaseDetailsInteractor.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 08.10.2023.

import Foundation

final class WeatherForecaseDetailsInteractor {
    // MARK: - Properties
    weak var output: WeatherForecaseDetailsInteractorOutput!
    
    // MARK: - State
    let weatherForecast: WeatherForecastDomainModel
    
    init(modulePayload: WeatherForecaseDetailsModulePayload) {
        self.weatherForecast = modulePayload.weatherForecast
    }
}

// MARK: - WeatherForecaseDetailsInteractorInputProtocol
extension WeatherForecaseDetailsInteractor: WeatherForecaseDetailsInteractorInput {
    func viewDidLoad() {
        output.reloadDays(days: weatherForecast, index: 0)
    }

    func didSelectDay(id: String) {
        guard let index = weatherForecast.forecast.firstIndex(where: { $0.date == id }) else {
            return
        }
        
        print("interactor \(id)")
        output.reloadDays(days: weatherForecast, index: index)
    }

}
