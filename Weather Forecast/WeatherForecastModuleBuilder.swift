//
//  WeatherForecastModuleBuilder.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 20.09.2023.
//

import UIKit

//class WeatherForecastModuleBuilder {
//    func build() -> WeatherForecastViewController {
//        let interactor = WeatherForecastInteractor()
//        let presenter = WeatherForecastPresenter()
//        let router = WeatherForecastRouter()
//        let storyboard: UIStoryboard = .init(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherForecastViewController") as! WeatherForecastViewController
//        viewController.presenter = presenter
//        presenter.viewController = viewController
//        interactor.presenter = presenter
//        router.viewController = viewController
//
//        return viewController
//    }
//}

class WeatherForecastModuleBuilder {
    func build() -> WeatherForecastViewController {
        let interactor = WeatherForecastInteractor()
        let presenter = WeatherForecastPresenter(interactor: interactor)
        let router = WeatherForecastRouter()
        let storyboard: UIStoryboard = .init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherForecastViewController") as! WeatherForecastViewController
        viewController.presenter = presenter
        presenter.viewController = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        
        // Теперь вызывайте метод build у презентера, чтобы начать загрузку данных
        presenter.build(completion: { weather, error in
            if let weatherData = weather {
                // Обновите интерфейс после получения данных о погоде
                viewController.updateUI(weatherData: weatherData)
            } else if let error = error {
                // Обработайте ошибку
                viewController.showError(message: error)
            }
        })
    
        return viewController
    }
}
