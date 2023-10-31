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
    func didSelectDay(id: String)
}

// MARK: - WeatherForecaseDetailsInteractorInput
protocol WeatherForecaseDetailsInteractorInput: AnyObject {
    /* Presenter -> Interactor */
    func viewDidLoad()
    func didSelectDay(id: String)
}

// MARK: - WeatherForecaseDetailsInteractorOutput
protocol WeatherForecaseDetailsInteractorOutput: AnyObject {
    /* Interactor -> Presenter */
    func reloadDays(days: WeatherForecastDomainModel, index: Int)
}

// MARK: - WeatherForecaseDetailsViewInput
protocol WeatherForecaseDetailsViewInput: AnyObject {
    /* Presenter -> ViewController */
    func updateDataSource(weatherData: WeatherForecastDomainModel)
    func reloadDataSource()
}
