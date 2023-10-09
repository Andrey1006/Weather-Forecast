//
//  WeatherForecaseDetailsProtocols.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 08.10.2023.
//

import Foundation

// MARK: - WeatherForecaseDetailsRouterInput
protocol WeatherForecaseDetailsRouterInput: AnyObject {
    /* Presenter -> Router */
}

// MARK: - WeatherForecaseDetailsViewInput
protocol WeatherForecaseDetailsViewOutput: AnyObject {
    /* View -> Presenter */
    func viewDidLoad()
}

// MARK: - WeatherForecaseDetailsInteractorInput
protocol WeatherForecaseDetailsInteractorInput: AnyObject {
    /* Presenter -> Interactor */
    func viewDidLoad()
}

// MARK: - WeatherForecaseDetailsInteractorOutput
protocol WeatherForecaseDetailsInteractorOutput: AnyObject {
    /* Interactor -> Presenter */
    func updateDataSource(weatherData: WeatherForecastDomainModel)
}

// MARK: - WeatherForecaseDetailsViewInput
protocol WeatherForecaseDetailsViewInput: AnyObject {
    /* Presenter -> ViewController */
    func updateDataSource(weatherData: WeatherForecastDomainModel)
}
