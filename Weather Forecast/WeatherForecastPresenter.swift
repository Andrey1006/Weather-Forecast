//
//  WeatherForecastPresenter.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 20.09.2023.
//

import Foundation
import Alamofire

protocol WeatherForecastPresenterProtocol: AnyObject {
    func didFetchWeatherData(_ weatherData: WeatherData)
    func didFailToFetchWeatherData(_ error: Error)
    func build(completion: @escaping (WeatherData?, NetworkError?) -> Void)
}

class WeatherForecastPresenter {
    weak var viewController: WeatherForecastViewControllerProtocol?
    var interactor: WeatherForecastInteractor?
    
    init(interactor: WeatherForecastInteractor) {
        self.interactor = interactor
    }
}

extension WeatherForecastPresenter: WeatherForecastPresenterProtocol {
    
    func build(completion: @escaping (WeatherData?, NetworkError?) -> Void) {
        interactor?.fetchData { result in
            switch result {
            case .success(let weatherData):
                completion(weatherData, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }

    }
    
    func didFetchWeatherData(_ weatherData: WeatherData) {
        viewController?.updateUI(weatherData: weatherData)
    }
    
    func didFailToFetchWeatherData(_ error: Error) {
        viewController?.showError(message: error)
    }
    
}
