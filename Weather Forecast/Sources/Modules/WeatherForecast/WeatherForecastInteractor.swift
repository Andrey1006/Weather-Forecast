//
//  WeatherForecastInteractor.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 28.09.2023.

import Foundation
import Alamofire

final class WeatherForecastInteractor {
    // MARK: - Properties
    weak var output: WeatherForecastInteractorOutput!
    
    // MARK: - Service
    private let weatherForecastNetworkService: WeatherForecastNetworkService = .init()
    
    // MARK: - State
    private var weatherForecast: WeatherForecastDomainModel?
}

// MARK: - WeatherForecastInteractorInputProtocol
extension WeatherForecastInteractor: WeatherForecastInteractorInput {
    
    func viewDidLoad() {
        // TODO: Show loading state
        
        weatherForecastNetworkService.fetchData(region: "Kyiv", days: 3) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let weatherForecast):
                self.weatherForecast = weatherForecast
                self.output.updateDataSource(weatherData: weatherForecast)
            case .failure(let error):
                print(error)
                // TODO: Show error state
            }
        }
    }
    
    func didTapOnDayCell(id: String) {
        guard let weatherForecast else { return }
        
        output.presentWeatherForecaseDetailsScreen(weatherData: weatherForecast, day: 1)
    }
}
