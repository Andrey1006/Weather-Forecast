//
//  WeatherForecastInteractor.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 28.09.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation
import Alamofire

final class WeatherForecastInteractor {
    // MARK: - Properties
    weak var output: WeatherForecastInteractorOutput!
    let abc: WeatherForecastNetworkService = .init()
}

// MARK: - WeatherForecastInteractorInputProtocol
extension WeatherForecastInteractor: WeatherForecastInteractorInput {
    
    func viewDidLoad() {
        abc.fetchData(region: "Kyiv", days: 3) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.output.resultWeather(weatherData: success)
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
