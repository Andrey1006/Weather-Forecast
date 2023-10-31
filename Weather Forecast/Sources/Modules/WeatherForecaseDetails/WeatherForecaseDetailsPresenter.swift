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
    private var viewModel: WeatherForecastDetailsViewModel
    private let interactor: WeatherForecaseDetailsInteractorInput
    private let router: WeatherForecaseDetailsRouterInput

    // MARK: - Init
    init(
        view: WeatherForecaseDetailsViewInput,
        viewModel: WeatherForecastDetailsViewModel,
        interactor: WeatherForecaseDetailsInteractorInput,
        router: WeatherForecaseDetailsRouterInput
    ) {
        self.view = view
        self.viewModel = viewModel
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - WeatherForecaseDetailsPresenterProtocol
extension WeatherForecaseDetailsPresenter: WeatherForecaseDetailsViewOutput {
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
    
    func didSelectDay(id: String) {
        interactor.didSelectDay(id: id)
    }
}


// MARK: - WeatherForecaseDetailsInteractorOutputProtocol
extension WeatherForecaseDetailsPresenter: WeatherForecaseDetailsInteractorOutput {
    func reloadDays(days: WeatherForecastDomainModel, index: Int) {
        var cells: [WeatherForecastDetailsKindCellViewModel] = []
        
        for i in 0 ..< days.forecast.count {
            let dateFormatter: DateFormatter = .init()
            dateFormatter.dateFormat = "yy-MM-dd"
            
            let date = dateFormatter.date(from: days.forecast[i].date)
            
            let calendar = Calendar.current
            let dayOfWeek = calendar.component(.weekday, from: date ?? .now)
            let numberDayOfWeek = calendar.component(.day, from: date ?? .now)
            let weekdayNames = dateFormatter.shortWeekdaySymbols
            let dayOfWeekName = weekdayNames?[dayOfWeek - 1] ?? "error"
            
            cells.append(
                .dayOfTheWeek(
                    .init(
                        id: days.forecast[i].date,
                        dayOfTheWeek: String(dayOfWeekName.prefix(1)),
                        date: String(numberDayOfWeek),
                        isSelected: i == index
                    )
                )
            )
        }
        
        viewModel.dataSource.inject(
            section: .init(
                id: .dayOfTheWeek,
                items: cells
            )
        )
        
//        view.updateDataSource(weatherData: days.forecast[index])
        view.reloadDataSource()
    }
}


