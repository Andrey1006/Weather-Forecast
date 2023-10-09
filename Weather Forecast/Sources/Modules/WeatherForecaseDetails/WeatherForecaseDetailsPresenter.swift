//
//  WeatherForecaseDetailsPresenter.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 08.10.2023.
//

import Foundation

// MARK: - WeatherForecaseDetailsModulePayload
struct WeatherForecaseDetailsModulePayload {
    /* use for transfer data to the module */
    let weatherForecast: WeatherForecastDomainModel
    let day: Int
}

final class WeatherForecaseDetailsPresenter {
    // MARK: - Properties
    weak private var view: WeatherForecaseDetailsViewInput!
    private let interactor: WeatherForecaseDetailsInteractorInput
    private let router: WeatherForecaseDetailsRouterInput

    // MARK: - Init
    init(
        view: WeatherForecaseDetailsViewInput,
        interactor: WeatherForecaseDetailsInteractorInput,
        router: WeatherForecaseDetailsRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - WeatherForecaseDetailsPresenterProtocol
extension WeatherForecaseDetailsPresenter: WeatherForecaseDetailsViewOutput {
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
}


// MARK: - WeatherForecaseDetailsInteractorOutputProtocol
extension WeatherForecaseDetailsPresenter: WeatherForecaseDetailsInteractorOutput {
    func updateDataSource(weatherData: WeatherForecastDomainModel) {
        view.updateDataSource(weatherData: weatherData)
    }
}
