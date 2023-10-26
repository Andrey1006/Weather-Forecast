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
    func updateDataSource(weatherData: WeatherForecastDomainModel) {
        
        viewModel.dataSource.inject(
            section: .init(
                id: .dayOfTheWeek,
                items: createCalendarCellViewModel(weatherData: weatherData)
            )
        )

        view.updateDataSource(weatherData: weatherData)
        view.reloadDataSource()
    }
    
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
        
//        view.updateDataSource(weatherData: days)
        view.reloadDataSource()
        
//        return cells
    }
    
    func uppendCells(days: WeatherForecastDomainModel, index: Int) -> [CalendarCellViewModel] {
        var result: [CalendarCellViewModel] = []
        
        for i in 0 ..< days.forecast.count {
            
            let dateFormatter: DateFormatter = .init()
            dateFormatter.dateFormat = "yy-MM-dd"
            
            let date = dateFormatter.date(from: days.forecast[i].date)
            
            let calendar = Calendar.current
            let dayOfWeek = calendar.component(.weekday, from: date ?? .now)
            let numberDayOfWeek = calendar.component(.day, from: date ?? .now)
            let weekdayNames = dateFormatter.shortWeekdaySymbols
            let dayOfWeekName = weekdayNames?[dayOfWeek - 1] ?? "error"
            
            result.append(
                    .init(
                        id: days.forecast[i].date,
                        dayOfTheWeek: String(dayOfWeekName.prefix(1)),
                        date: String(numberDayOfWeek),
                        isSelected: i == index
                    )
                )
        }
        
        return result
    }

}

private extension WeatherForecaseDetailsPresenter {    
    func createCalendarCellViewModel(weatherData: WeatherForecastDomainModel) -> [WeatherForecastDetailsKindCellViewModel] {

        var result: [WeatherForecastDetailsKindCellViewModel] = []
        
        for item in weatherData.forecast {
            
            let dateFormatter: DateFormatter = .init()
            dateFormatter.dateFormat = "yy-MM-dd"
            
            let date = dateFormatter.date(from: item.date)
            
            let calendar = Calendar.current
            let dayOfWeek = calendar.component(.weekday, from: date ?? .now)
            let numberDayOfWeek = calendar.component(.day, from: date ?? .now)
            let weekdayNames = dateFormatter.shortWeekdaySymbols
            let dayOfWeekName = weekdayNames?[dayOfWeek - 1] ?? "error"
            
            result.append(
                .dayOfTheWeek(
                    .init(
                        id: item.date,
                        dayOfTheWeek: String(dayOfWeekName.prefix(1)),
                        date: String(numberDayOfWeek)
                    )
                )
            )
        }
    
        return result
    }
}


//var selectedDay: String = ""
//    var days: [CalendarCellViewModel] = []
//
//func updateSelectedDay(id: String) {
//    guard let index = days.firstIndex(where: { $0.id == id }) else {
//        return
//    }
//
////    view.reloadDays(days: days, index: index)
//}
//    // presenter
//
//func rleoadDays(days: WeatherForecastDomainModel, index: Int) {
//    var cells: [CalendarCellViewModel] = []
//    for i in 0 ..< days.forecast.count {
//        cells.append(
//            .init(
//                id: "1",
//                dayOfTheWeek: "1", // String(dayOfWeekName.prefix(1)),
//                date: "1",  //String(numberDayOfWeek),
//                isSelected: i == index
//            )
//        )
//    }
//}
