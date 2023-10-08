//
//  WeatherForecastPresenter.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 28.09.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - WeatherForecastModulePayload
struct WeatherForecastModulePayload {
    /* use for transfer data to the module */
}

final class WeatherForecastPresenter: WeatherForecastModuleInput {
    
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

    // MARK: - WeatherForecastModuleInput
    func launch(_ modulePayload: WeatherForecastModulePayload) {

    }
}

// MARK: - WeatherForecastInteractorOutputProtocol
extension WeatherForecastPresenter: WeatherForecastInteractorOutput {
    
    
    func resultWeather(weatherData: WeatherForecastDomainModel) {

    var test: [WeatherForecastKindCellViewModel] = []
        for item in weatherData.forecast {
            test.append(
                .detail(
                    .init(
                        layout: .init(roundStrategy: .single),
                        id: item.date,
                        date: item.date,
                        image: "plus",
                        minTemperature: String(item.minTempereture),
                        maxTemperature: String(item.maxTempereture),
                        width: viewModel.viewWidth
                    )
                )
            )
        }
        
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
                items: test
            )
        )
        
        viewModel.dataSource.inject(
            section: .init(
                id: .map,
                items: [.map(.init(id: "132", width: viewModel.viewWidth))])
        )
        
        viewModel.dataSource.inject(
            section: .init(
                id: .attributes,
                items: [
//                    .attributes(
//                        .init(
//                            id: "1",
//                            title: weatherData.forecast[0].currentHourWeather?.time ?? "",
//                            value: String(weatherData.forecast[0].currentHourWeather?.uVIndex ?? 0),
//                            width: 180
//                        )
//                    ),
//                    .attributes(
//                        .init(
//                            id: "2",
//                            title: "Заход солнца",
//                            value: String(weatherData.forecast[0].sunset),
//                            description: String(weatherData.forecast[0].sunrise),
//                            width: 180
//                        )
//                    )
                    .attributes(
                        .init(
                            id: "3",
                            title: "Чувствуется как",
                            value: String(weatherData.currentHourWeather.feelslike),
                            description: "Примерно как фактическая температура",
                            width: 180
                        )
                    ),
                    .attributes(
                        .init(
                            id: "4",
                            title: "Чувствуется как",
                            value: String(weatherData.currentHourWeather.feelslike),
                            description: "Примерно как фактическая температура",
                            width: 180
                        )
                    )

                ]
            )
        )
        view.reloadDataSource()
    }
}

// MARK: - WeatherForecastPresenterProtocol
extension WeatherForecastPresenter: WeatherForecastViewOutput {
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
}

private extension WeatherForecastPresenter {
    func createBriefInformationCellViewModel(weatherData: WeatherForecastDomainModel) -> [BriefInformationCellViewModel] {
        
        var result: [BriefInformationCellViewModel] = []
        
        let date: Date = .init()
        
        for dayForecast in weatherData.forecast {
            for hourForecast in dayForecast.hourForecast {
                if date.description < hourForecast.time && result.count < 24 {
                    result.append(
                        .init(
                            id: hourForecast.time,
                            date: hourForecast.time,
                            image: .init(systemName: "square.and.arrow.up")!,
                            temperature: String(hourForecast.temperature),
                            width: 200
                        )
                    )
                }
            }
        }
    
        return result
    }
}

































//func createBriefInformationCellViewModel(
//    for id: DetailInformationKind,
//    kind: [String],
//    width: CGFloat
//) -> BriefIInformationsCollectionViewModel {
//
//    return .init(id: id.rawValue, items: [], width: width)
//}
//}
//
//func createDetailInformationCellViewModel(for id: DetailInformationKind) {
//
//}


//        interactor.fetchData { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let success):
//                viewModel.dataSource.inject(
//                    section: .init(
//                        id: .brief,
//                        items: [.brief(
//                            .init(
//                                id: "11",
//                                items: [
//                                    .init(id: "1", date: "Сейчас", image: .init(systemName: "square.and.arrow.up")!, temperature: String(success.current.temp_c), width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50)
//                                ],
//                                width: viewModel.viewWidth
//                            )
//                        )]
//                    )
//                )
//
//                viewModel.dataSource.inject(
//                    section: .init(
//                        id: .detail,
//                        items: [
//                            .detail(
//                                .init(
//                                    layout: .init(roundStrategy: .first),
//                                    id: "1",
//                                    date: success.forecast.forecastday[0].date,
//                                    image: .init(systemName: "square.and.arrow.up")!,
//                                    minTemperature: String(success.forecast.forecastday[0].day.mintemp_c),
//                                    maxTemperature: String(success.forecast.forecastday[0].day.maxtemp_c),
//                                    width: viewModel.viewWidth
//                                )
//                            ),
//                            .detail(
//                                .init(
//                                    layout: .init(roundStrategy: .middle),
//                                    id: "2",
//                                    date: success.forecast.forecastday[1].date,
//                                    image: .init(systemName: "square.and.arrow.up")!,
//                                    minTemperature: String(success.forecast.forecastday[1].day.mintemp_c),
//                                    maxTemperature: String(success.forecast.forecastday[1].day.maxtemp_c),
//                                    width: viewModel.viewWidth
//                                )
//                            ),
//                            .detail(
//                                .init(
//                                    layout: .init(roundStrategy: .last),
//                                    id: "3",
//                                    date: success.forecast.forecastday[2].date,
//                                    image: .init(systemName: "square.and.arrow.up")!,
//                                    minTemperature: String(success.forecast.forecastday[2].day.mintemp_c),
//                                    maxTemperature: String(success.forecast.forecastday[2].day.maxtemp_c),
//                                    width: viewModel.viewWidth
//                                )
//                            )
//                        ]
//                    )
//                )
//            case .failure(let failure):
//                print(failure)
//            }
//            view.reloadDataSource()
//        }
//                let insets: CGFloat = 24
//                let countOfItemsInRow: CGFloat = 2
//                let cellWidth: CGFloat = floor(
//                    (viewModel.viewWidth - (insets * 2) - (insets * (countOfItemsInRow - 1))) / countOfItemsInRow
//                )
//
//                viewModel.dataSource.inject(
//                    section: .init(
//                        id: .brief,
//                        items: [.brief(
//                            .init(
//                                id: "1",
//                                items: [
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50)
//                                ],
//                                width: viewModel.viewWidth
//                            )
//                        )]
//                    )
//                )
//
//                    viewModel.dataSource.inject(
//                        section: .init(
//                            id: .detail,
//                            items: [
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .first),
//                                        id: "1",
//                                        date: "1",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "1",
//                                        maxTemperature: "2",
//                                        width: viewModel.viewWidth
//                                    )
//                                ),
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .middle),
//                                        id: "2",
//                                        date: "2",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "2",
//                                        maxTemperature: "2",
//                                        width: viewModel.viewWidth
//                                    )
//                                ),
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .middle),
//                                        id: "3",
//                                        date: "3",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "3",
//                                        maxTemperature: "3",
//                                        width: viewModel.viewWidth
//                                    )
//                                ),
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .middle),
//                                        id: "14",
//                                        date: "3",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "3",
//                                        maxTemperature: "3",
//                                        width: viewModel.viewWidth
//                                    )
//                                ),
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .middle),
//                                        id: "13",
//                                        date: "3",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "3",
//                                        maxTemperature: "3",
//                                        width: viewModel.viewWidth
//                                    )
//                                ),
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .middle),
//                                        id: "12",
//                                        date: "3",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "3",
//                                        maxTemperature: "3",
//                                        width: viewModel.viewWidth
//                                    )
//                                ),
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .middle),
//                                        id: "11",
//                                        date: "3",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "3",
//                                        maxTemperature: "3",
//                                        width: viewModel.viewWidth
//                                    )
//                                ),
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .last),
//                                        id: "4",
//                                        date: "4",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "4",
//                                        maxTemperature: "4",
//                                        width: viewModel.viewWidth
//                                    )
//                                )
//                            ]
//                        )
//                    )
//
//                viewModel.dataSource.inject(
//                    section: .init(
//                        id: .map,
//                        items: [.map(.init(id: "3", width: viewModel.viewWidth))]
//                    )
//                )
//
//                viewModel.dataSource.inject(
//                    section: .init(
//                        id: .attributes,
//                        items: [
//                            .attributes(
//                                .init(
//                                    id: "4",
//                                    title: "Ощущается как",
//                                    value: "15°",
//                                    description: "Из-за ветра кажется что прохладнее",
//                                    width: cellWidth
//                                )
//                            ),
//                            .attributes(
//                                .init(
//                                    id: "5",
//                                    title: "Ощущается как",
//                                    value: "15°",
//                                    description: "Из-за ветра кажется что прохладнее",
//                                    width: cellWidth
//                                )
//                            ),
//                            .attributes(
//                                .init(
//                                    id: "6",
//                                    title: "Ощущается как",
//                                    value: "15°",
//                                    description: "Из-за ветра кажется что прохладнее",
//                                    width: cellWidth
//                                )
//                            ),
//                            .attributes(
//                                .init(
//                                    id: "7",
//                                    title: "Ощущается как",
//                                    value: "15°",
//                                    description: "Из-за ветра кажется что прохладнее",
//                                    width: cellWidth
//                                )
//                            )
//                        ],
//                        insets: .init(top: insets, left: insets, bottom: 0, right: insets),
//                        interitemSpacing: insets,
//                        lineSpacing: insets
//                    )
//                )
//
//        view.reloadDataSource()
//        interactor.fetchData { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let success):
//                viewModel.dataSource.inject(
//                    section: .init(
//                        id: .brief,
//                        items: [.brief(
//                            .init(
//                                id: "11",
//                                items: [
//                                    .init(id: "1", date: "Сейчас", image: .init(systemName: "square.and.arrow.up")!, temperature: String(success.current.temp_c), width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50)
//                                ],
//                                width: viewModel.viewWidth
//                            )
//                        )]
//                    )
//                )
//
//                viewModel.dataSource.inject(
//                    section: .init(
//                        id: .detail,
//                        items: [
//                            .detail(
//                                .init(
//                                    layout: .init(roundStrategy: .first),
//                                    id: "1",
//                                    date: success.forecast.forecastday[0].date,
//                                    image: .init(systemName: "square.and.arrow.up")!,
//                                    minTemperature: String(success.forecast.forecastday[0].day.mintemp_c),
//                                    maxTemperature: String(success.forecast.forecastday[0].day.maxtemp_c),
//                                    width: viewModel.viewWidth
//                                )
//                            ),
//                            .detail(
//                                .init(
//                                    layout: .init(roundStrategy: .middle),
//                                    id: "2",
//                                    date: success.forecast.forecastday[1].date,
//                                    image: .init(systemName: "square.and.arrow.up")!,
//                                    minTemperature: String(success.forecast.forecastday[1].day.mintemp_c),
//                                    maxTemperature: String(success.forecast.forecastday[1].day.maxtemp_c),
//                                    width: viewModel.viewWidth
//                                )
//                            ),
//                            .detail(
//                                .init(
//                                    layout: .init(roundStrategy: .last),
//                                    id: "3",
//                                    date: success.forecast.forecastday[2].date,
//                                    image: .init(systemName: "square.and.arrow.up")!,
//                                    minTemperature: String(success.forecast.forecastday[2].day.mintemp_c),
//                                    maxTemperature: String(success.forecast.forecastday[2].day.maxtemp_c),
//                                    width: viewModel.viewWidth
//                                )
//                            )
//                        ]
//                    )
//                )
//            case .failure(let failure):
//                print(failure)
//            }
//            view.reloadDataSource()
//        }
//                let insets: CGFloat = 24
//                let countOfItemsInRow: CGFloat = 2
//                let cellWidth: CGFloat = floor(
//                    (viewModel.viewWidth - (insets * 2) - (insets * (countOfItemsInRow - 1))) / countOfItemsInRow
//                )
//
//                viewModel.dataSource.inject(
//                    section: .init(
//                        id: .brief,
//                        items: [.brief(
//                            .init(
//                                id: "1",
//                                items: [
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50),
//                                    .init(id: "1", date: "1", image: .init(systemName: "square.and.arrow.up")!, temperature: "1", width: 50)
//                                ],
//                                width: viewModel.viewWidth
//                            )
//                        )]
//                    )
//                )
//
//                    viewModel.dataSource.inject(
//                        section: .init(
//                            id: .detail,
//                            items: [
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .first),
//                                        id: "1",
//                                        date: "1",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "1",
//                                        maxTemperature: "2",
//                                        width: viewModel.viewWidth
//                                    )
//                                ),
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .middle),
//                                        id: "2",
//                                        date: "2",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "2",
//                                        maxTemperature: "2",
//                                        width: viewModel.viewWidth
//                                    )
//                                ),
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .middle),
//                                        id: "3",
//                                        date: "3",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "3",
//                                        maxTemperature: "3",
//                                        width: viewModel.viewWidth
//                                    )
//                                ),
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .middle),
//                                        id: "14",
//                                        date: "3",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "3",
//                                        maxTemperature: "3",
//                                        width: viewModel.viewWidth
//                                    )
//                                ),
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .middle),
//                                        id: "13",
//                                        date: "3",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "3",
//                                        maxTemperature: "3",
//                                        width: viewModel.viewWidth
//                                    )
//                                ),
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .middle),
//                                        id: "12",
//                                        date: "3",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "3",
//                                        maxTemperature: "3",
//                                        width: viewModel.viewWidth
//                                    )
//                                ),
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .middle),
//                                        id: "11",
//                                        date: "3",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "3",
//                                        maxTemperature: "3",
//                                        width: viewModel.viewWidth
//                                    )
//                                ),
//                                .detail(
//                                    .init(
//                                        layout: .init(roundStrategy: .last),
//                                        id: "4",
//                                        date: "4",
//                                        image: .init(systemName: "square.and.arrow.up")!,
//                                        minTemperature: "4",
//                                        maxTemperature: "4",
//                                        width: viewModel.viewWidth
//                                    )
//                                )
//                            ]
//                        )
//                    )
//
//                viewModel.dataSource.inject(
//                    section: .init(
//                        id: .map,
//                        items: [.map(.init(id: "3", width: viewModel.viewWidth))]
//                    )
//                )
//
//                viewModel.dataSource.inject(
//                    section: .init(
//                        id: .attributes,
//                        items: [
//                            .attributes(
//                                .init(
//                                    id: "4",
//                                    title: "Ощущается как",
//                                    value: "15°",
//                                    description: "Из-за ветра кажется что прохладнее",
//                                    width: cellWidth
//                                )
//                            ),
//                            .attributes(
//                                .init(
//                                    id: "5",
//                                    title: "Ощущается как",
//                                    value: "15°",
//                                    description: "Из-за ветра кажется что прохладнее",
//                                    width: cellWidth
//                                )
//                            ),
//                            .attributes(
//                                .init(
//                                    id: "6",
//                                    title: "Ощущается как",
//                                    value: "15°",
//                                    description: "Из-за ветра кажется что прохладнее",
//                                    width: cellWidth
//                                )
//                            ),
//                            .attributes(
//                                .init(
//                                    id: "7",
//                                    title: "Ощущается как",
//                                    value: "15°",
//                                    description: "Из-за ветра кажется что прохладнее",
//                                    width: cellWidth
//                                )
//                            )
//                        ],
//                        insets: .init(top: insets, left: insets, bottom: 0, right: insets),
//                        interitemSpacing: insets,
//                        lineSpacing: insets
//                    )
//                )
//
//        view.reloadDataSource()
