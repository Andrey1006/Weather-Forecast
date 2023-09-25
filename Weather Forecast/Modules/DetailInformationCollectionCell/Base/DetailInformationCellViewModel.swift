//
//  DetailInformationCellViewModel.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import Foundation

struct DetailInformationCellViewModel: BaseCellViewModel {
    var layout: DetailInformationCellViewLayout = .init()
    var id: String
    var date: String
    var minTemperature: String
    var maxTemperature: String
    var size: CGSize = .zero
    
    init(layout: DetailInformationCellViewLayout = .init(), id: String, date: String, minTemperature: String, maxTemperature: String, width: CGFloat) {
        self.layout = layout
        self.id = id
        self.date = date
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
        return true
    }
}
