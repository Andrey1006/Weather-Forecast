//
//  WeatherForecastDetailsViewModel.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 13.10.2023.
//

import UIKit

enum FillDetailsCategoriesSectionID: String, Hashable {
    case dayOfTheWeek
}

enum WeatherForecastDetailsKindCellViewModel: Hashable, BaseCellViewModel {
    case dayOfTheWeek(CalendarCellViewModel)
    
    var id: some Hashable {
        switch self {
        case .dayOfTheWeek(let viewModel):
            return viewModel.id
        }
    }
    var size: CGSize {
        switch self {
        case .dayOfTheWeek(let viewModel):
            return viewModel.size
        }
    }
}
    
typealias DetailsDataSource = BaseDataSource<FillDetailsCategoriesSectionID, Nothing, WeatherForecastDetailsKindCellViewModel, Nothing>

class WeatherForecastDetailsViewModel {
    var viewWidth: CGFloat = .zero
    var dataSource: DetailsDataSource = .init()
}
