//
//  WeatherForecaseDetailsInteractor.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 08.10.2023.

import Foundation

final class WeatherForecaseDetailsInteractor {
    // MARK: - Properties
    weak var output: WeatherForecaseDetailsInteractorOutput!
    
    // MARK: - State
    let weatherForecast: WeatherForecastDomainModel
    
    init(modulePayload: WeatherForecaseDetailsModulePayload) {
        self.weatherForecast = modulePayload.weatherForecast
    }
}

// MARK: - WeatherForecaseDetailsInteractorInputProtocol
extension WeatherForecaseDetailsInteractor: WeatherForecaseDetailsInteractorInput {
    func viewDidLoad() {
        output.updateDataSource(weatherData: weatherForecast)
    }
    
    //var selectedDay: String = ""
//        var days: [CalendarCellViewModel] = []
    //
    //func updateSelectedDay(id: String) {
//        guard let index = days.firstIndex(where: { $0.id == id }) else {
//            return
//        }
    //
    //    view.reloadDays(days: days, index: index)
    
    func didSelectDay(id: String) {
        guard let index = weatherForecast.forecast.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        print("interactor \(id)")
        output.reloadDays(days: weatherForecast, index: index)
    }

}
