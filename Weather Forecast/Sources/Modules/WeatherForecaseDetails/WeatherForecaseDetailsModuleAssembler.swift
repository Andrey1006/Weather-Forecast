//
//  WeatherForecaseDetailsModuleAssembler.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 08.10.2023.
//

import UIKit

extension WeatherForecaseDetailsViewController {
    static func instantiate(modulePayload: WeatherForecaseDetailsModulePayload) -> WeatherForecaseDetailsViewController {
        let viewController: WeatherForecaseDetailsViewController = .instantiate(from: .main)
        let viewModel: WeatherForecastDetailsViewModel = .init()
        let interactor: WeatherForecaseDetailsInteractor = .init(modulePayload: modulePayload)
        let router: WeatherForecaseDetailsRouter = .init()
        let presenter: WeatherForecaseDetailsPresenter = .init(
            view: viewController,
            viewModel: viewModel,
            interactor: interactor,
            router: router
        )

        viewController.viewModel = viewModel
        viewController.output = presenter
        interactor.output = presenter
        
        return viewController
    }
}
