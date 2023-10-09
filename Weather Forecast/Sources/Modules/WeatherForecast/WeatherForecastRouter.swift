//
//  WeatherForecastRouter.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 28.09.2023.
//

import UIKit

final class WeatherForecastRouter: WeatherForecastRouterInput {
    // MARK: - Properties
    private weak var viewController: WeatherForecastViewController!

    init(viewController: WeatherForecastViewController) {
        self.viewController = viewController
    }
    
    // MARK: - WeatherForecastRouterInput
    func presentWeatherForecaseDetailsScreen(weatherData: WeatherForecastDomainModel, day: Int) {
        let weatherForecaseDetailsViewController: WeatherForecaseDetailsViewController = .instantiate(
            modulePayload: .init(weatherForecast: weatherData, day: day)
        )
        
        viewController.present(weatherForecaseDetailsViewController, animated: true)
    }
}
