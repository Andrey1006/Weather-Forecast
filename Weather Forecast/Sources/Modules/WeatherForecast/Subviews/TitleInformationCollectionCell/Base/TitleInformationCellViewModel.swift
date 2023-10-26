//
//  TitleInformationCellViewModel.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 11.10.2023.
//

import Foundation

struct TitleInformationCellViewModel: BaseCellViewModel {

    
    var id: String
    var title: String
    var value: String
    var weatherPhenomenon: String
    var maxAndMinTemperature: String
    
    var size: CGSize = .zero
    
    init(
        id: String,
        title: String,
        value: String,
        weatherPhenomenon: String,
        maxAndMinTemperature: String,
        width: CGFloat
    ) {
        self.id = id
        self.title = title
        self.value = value
        self.weatherPhenomenon = weatherPhenomenon
        self.maxAndMinTemperature = maxAndMinTemperature
        calculateSize(width: width)
    }
    
    private mutating func calculateSize(width: CGFloat) {
        size = .init(width: width, height: width / 2)
    }
}

// MARK: - Hashable
extension TitleInformationCellViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Equatable
extension TitleInformationCellViewModel: Equatable {
    static func == (
        lhs: TitleInformationCellViewModel,
        rhs: TitleInformationCellViewModel
    ) -> Bool {
        return KeyPathEqualizer(lhs: lhs, rhs: rhs)
            .compare(by: \.id)
            .compare(by: \.title)
            .compare(by: \.value)
            .compare(by: \.weatherPhenomenon)
            .compare(by: \.maxAndMinTemperature)
            .build()
    }
}
