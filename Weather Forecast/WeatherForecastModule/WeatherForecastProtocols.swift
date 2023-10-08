//
//  WeatherForecastProtocols.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 28.09.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - WeatherForecastModuleInput
protocol WeatherForecastModuleInput: AnyObject {
    /* entering point to the module */

    func launch(_ modulePayload: WeatherForecastModulePayload)
}

// MARK: - WeatherForecastRouterInput
protocol WeatherForecastRouterInput: AnyObject {
    /* Presenter -> Router */
}

// MARK: - WeatherForecastViewInput
protocol WeatherForecastViewOutput: AnyObject {
    /* View -> Presenter */
    func viewDidLoad()
}

// MARK: - WeatherForecastInteractorInput
protocol WeatherForecastInteractorInput: AnyObject {
    /* Presenter -> Interactor */
    func viewDidLoad()
}

// MARK: - WeatherForecastInteractorOutput
protocol WeatherForecastInteractorOutput: AnyObject {
    /* Interactor -> Presenter */
    func resultWeather(weatherData: WeatherForecastDomainModel)
    func viewDidLoad()
}

// MARK: - WeatherForecastViewInput
protocol WeatherForecastViewInput: AnyObject {
    /* Presenter -> ViewController */
    func reloadDataSource()
}




