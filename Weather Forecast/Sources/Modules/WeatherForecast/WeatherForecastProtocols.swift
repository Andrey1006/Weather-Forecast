//
//  WeatherForecastProtocols.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 28.09.2023.
//

import Foundation

// MARK: - WeatherForecastRouterInput
protocol WeatherForecastRouterInput: AnyObject {
    /* Presenter -> Router */
    func presentWeatherForecaseDetailsScreen(weatherData: WeatherForecastDomainModel, day: Int)
}

// MARK: - WeatherForecastViewInput
protocol WeatherForecastViewOutput: AnyObject {
    /* View -> Presenter */
    func viewDidLoad()
    
    func didTapOnDayCell(id: String)
}

// MARK: - WeatherForecastInteractorInput
protocol WeatherForecastInteractorInput: AnyObject {
    /* Presenter -> Interactor */
    func viewDidLoad()
    
    func didTapOnDayCell(id: String)
}

// MARK: - WeatherForecastInteractorOutput
protocol WeatherForecastInteractorOutput: AnyObject {
    /* Interactor -> Presenter */
    func viewDidLoad()
    
    func updateDataSource(weatherData: WeatherForecastDomainModel)
    func presentWeatherForecaseDetailsScreen(weatherData: WeatherForecastDomainModel, day: Int)
}

// MARK: - WeatherForecastViewInput
protocol WeatherForecastViewInput: AnyObject {
    /* Presenter -> ViewController */
    func reloadDataSource()
}




