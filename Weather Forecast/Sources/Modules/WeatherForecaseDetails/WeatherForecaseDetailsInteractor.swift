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
        output.updateDataSource(weatherData: weatherForecast)
    }

}
