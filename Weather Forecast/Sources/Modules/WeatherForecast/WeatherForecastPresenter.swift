//
//  WeatherForecastPresenter.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 28.09.2023.
//

import Foundation
import Alamofire
import UIKit

// MARK: - WeatherForecastModulePayload
struct WeatherForecastModulePayload {
    /* use for transfer data to the module */
    let weatherForecase: WeatherForecastDomainModel
}

final class WeatherForecastPresenter {
    
    // MARK: - Properties
    weak private var view: WeatherForecastViewInput!
    private var viewModel: WeatherForecastViewModel
    private let interactor: WeatherForecastInteractorInput
    private let router: WeatherForecastRouterInput

    var viewIsReady: Bool = true
    
    // MARK: - Init
    init(
        view: WeatherForecastViewInput,
        viewModel: WeatherForecastViewModel,
        interactor: WeatherForecastInteractorInput,
        router: WeatherForecastRouterInput
    ) {
        self.view = view
        self.viewModel = viewModel
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - WeatherForecastInteractorOutputProtocol
extension WeatherForecastPresenter: WeatherForecastInteractorOutput {
    func updateDataSource(weatherData: WeatherForecastDomainModel) {
        var weatherDetails: [WeatherForecastKindCellViewModel] = []
        
        func roundStrategy() -> DetailInformationCellViewLayout {
            switch weatherDetails.count {
            case 0:
                return .init(roundStrategy: .first)
            case 1:
                return .init(roundStrategy: .middle)
            default:
                return .init(roundStrategy: .last)
            }
        }
                
        for item in weatherData.forecast {
            
            let dateFormatter: DateFormatter = .init()
            dateFormatter.dateFormat = "yy-MM-dd"
            
            let date = dateFormatter.date(from: item.date)
            
            let calendar = Calendar.current
            let dayOfWeek = calendar.component(.weekday, from: date ?? .now)
            let weekdayNames = dateFormatter.shortWeekdaySymbols
            let dayOfWeekName = weekdayNames?[dayOfWeek - 1] ?? "error"
    
            weatherDetails.append(
                .detail(
                    .init(
                        layout: roundStrategy(),
                        id: item.date,
                        date: dayOfWeekName,
                        image: "https:\(item.icon)",
                        minTemperature: "\(String(item.minTempereture))°",
                        maxTemperature: "\(String(item.maxTempereture))°",
                        width: viewModel.viewWidth
                    )
                )
            )
        }
        
        viewModel.dataSource.inject(
            section: .init(
                id: .title,
                items: [
                    .title(
                        .init(
                            id: "6543",
                            title: "Киев",
                            value: "\(weatherData.currentHourWeather.temperature)°",
                            weatherPhenomenon: weatherData.currentHourWeather.text,
                            maxAndMinTemperature: "Макс.:\(String(weatherData.forecast[0].maxTempereture))°,мин.:\(String(weatherData.forecast[0].minTempereture))°",
                            width: viewModel.viewWidth
                        )
                    )
                ]
            )
        )
        
            viewModel.dataSource.inject(
                section: .init(
                    id: .brief,
                    items: [
                        .brief(
                            .init(
                                id: "123das",
                                items: createBriefInformationCellViewModel(weatherData: weatherData),
                                width: viewModel.viewWidth
                            )
                        )
                    ]
                )
            )


            viewModel.dataSource.inject(
                section: .init(
                    id: .detail,
                    items: weatherDetails
                )
            )
            
            viewModel.dataSource.inject(
                section: .init(
                    id: .map,
                    items: [
                        .map(
                            .init(
                                id: "132",
                                currentLocationTemperature: String(weatherData.currentHourWeather.temperature),
                                width: viewModel.viewWidth
                            )
                        )
                    ]
                )
            )
        
            viewModel.dataSource.inject(
                section: .init(
                    id: .attributes,
                    items: [
                    .attributes(
                        .init(
                            id: "3",
                            title: "Ощущается как",
                            value: "\(String(weatherData.currentHourWeather.feelslike))°",
                            width: viewModel.viewWidth / 2
                        )
                    ),
                    .attributes(
                        .init(
                            id: "4",
                            title: "Оcaдки",
                            value: "\(String(weatherData.currentHourWeather.totalPrecipitation)) ММ",
                            width: viewModel.viewWidth / 2
                        )
                    ),
                    .attributes(
                        .init(
                            id: "6",
                            title: "Влажность",
                            value: "\(String(weatherData.currentHourWeather.humidity)) %",
                            width: viewModel.viewWidth / 2
                        )
                    ),
                    .attributes(
                        .init(
                            id: "5",
                            title: "Видимость",
                            value: "\(String(weatherData.currentHourWeather.visibilityKm)) КМ",
                            width: viewModel.viewWidth / 2
                        )
                    ),
                ]
            )
        )
        viewModel.dataSource.inject(
            section: .init(
                id: .directionWind ,
                items: [
                    .directionWind(
                        .init(
                            id: "1",
                            title: "💨 Ветер",
                            direction: weatherData.currentHourWeather.windDirection,
                            value: "\(String(weatherData.currentHourWeather.windKph))км/ч",
                            width: viewModel.viewWidth / 2
                        )
                    )
                ]
            )
        )
        
        view.reloadDataSource()
    }
    
    func presentWeatherForecaseDetailsScreen(weatherData: WeatherForecastDomainModel, day: Int) {
        router.presentWeatherForecaseDetailsScreen(weatherData: weatherData, day: day)
    }
}

// MARK: - WeatherForecastPresenterProtocol
extension WeatherForecastPresenter: WeatherForecastViewOutput {
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
    
    func didTapOnDayCell(id: String) {
        interactor.didTapOnDayCell(id: id)
    }
}

private extension WeatherForecastPresenter {
    func createBriefInformationCellViewModel(weatherData: WeatherForecastDomainModel) -> [BriefInformationCellViewModel] {
        
        var result: [BriefInformationCellViewModel] = []
        
        let date: Date = .now + 7200
        
        for dayForecast in weatherData.forecast {
            for hourForecast in dayForecast.hourForecast {
                if date.description < hourForecast.time && result.count < 24 {
                    
                    let dateFormatter: DateFormatter = .init()
                    dateFormatter.dateFormat = "yy-MM-dd HH:mm"
                    let test = dateFormatter.date(from: hourForecast.time)
                    dateFormatter.dateFormat = "HH"
                    let formattedHour = dateFormatter.string(from: test ?? .now)
                    
                    result.append(
                        .init(
                            id: hourForecast.time,
                            date: formattedHour,
                            image: "https:\(hourForecast.icon)",
                            temperature: "\(String(hourForecast.temperature))°"
                        )
                    )
                }
            }
        }
    
        return result
    }
}

