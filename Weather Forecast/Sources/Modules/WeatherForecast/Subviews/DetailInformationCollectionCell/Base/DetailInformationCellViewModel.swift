//
//  DetailInformationCellViewModel.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

struct DetailInformationCellViewModel: BaseCellViewModel {
    var layout: DetailInformationCellViewLayout
    var id: String
    var date: String
    var image: String
    var minTemperature: String
    var maxTemperature: String
    var size: CGSize = .zero
    
    init(
        layout: DetailInformationCellViewLayout,
        id: String,
        date: String,
        image: String,
        minTemperature: String,
        maxTemperature: String,
        width: CGFloat
    ) {
        self.layout = layout
        self.id = id
        self.date = date
        self.image = image
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        calculateSize(width: width)
    }
    
    private mutating func calculateSize(width: CGFloat) {
        size = .init(width: width, height: layout.innerContentInsets.vertical + layout.outerContentInsets.vertical + layout.imageHeight)
    }
}

// MARK: - Hashable
extension DetailInformationCellViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Equatable
extension DetailInformationCellViewModel: Equatable {
    static func == (lhs: DetailInformationCellViewModel, rhs: DetailInformationCellViewModel) -> Bool {
        return KeyPathEqualizer(lhs: lhs, rhs: rhs)
            .compare(by: \.id)
            .compare(by: \.date)
            .compare(by: \.image)
            .compare(by: \.minTemperature)
            .compare(by: \.maxTemperature)
            .build()
    }
}

enum RoundedSectionItemKind {
    case first
    case middle
    case last
    case single
}
