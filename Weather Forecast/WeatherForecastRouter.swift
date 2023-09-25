//
//  WeatherForecastRouter.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 20.09.2023.
//

import Foundation

protocol WeatherForecastRouterProtocol {
    func presentDetail()
}

class WeatherForecastRouter: WeatherForecastRouterProtocol {
    weak var viewController: WeatherForecastViewController?
    
    func presentDetail() {
        
    }
}
