//
//  WeatherForecastViewModel.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 28.09.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum FillCategoriesSectionID: String, Hashable {
    case brief
    case detail
    case map
    case attributes
}

enum WeatherForecastKindCellViewModel: Hashable, BaseCellViewModel {
    case brief(BriefIInformationsCollectionViewModel)
    case detail(DetailInformationCellViewModel)
    case map(MapInformationCellViewModel)
    case attributes(AttributesInformationCellViewModel)
    
    var id: some Hashable {
        switch self {
        case .brief(let viewModel):
            return viewModel.id
        case .detail(let viewModel):
            return viewModel.id
        case .map(let viewModel):
            return viewModel.id
        case .attributes(let viewModel):
            return viewModel.id
        }
    }
    
    var size: CGSize {
        switch self {
        case .brief(let viewModel):
            return viewModel.size
        case .detail(let viewModel):
            return viewModel.size
        case .map(let viewModel):
            return viewModel.size
        case .attributes(let viewModel):
            return viewModel.size
        }
    }
}

typealias DataSource = BaseDataSource<FillCategoriesSectionID, Nothing, WeatherForecastKindCellViewModel, Nothing>

class WeatherForecastViewModel {
    var viewWidth: CGFloat = .zero
    var dataSource: DataSource = .init()
}
