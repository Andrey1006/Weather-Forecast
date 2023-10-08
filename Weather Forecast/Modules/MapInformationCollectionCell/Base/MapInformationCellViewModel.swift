//
//  MapInformationCellViewModel.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import Foundation

struct MapInformationCellViewModel: BaseCellViewModel {
    var id: String
    var size: CGSize = .zero
    
    init(id: String, width: CGFloat) {
        self.id = id
        calculateSize(width: width)
    }
    
    private mutating func calculateSize(width: CGFloat) {
        size = .init(width: width, height: width)
    }
}

// MARK: - Hashable
extension MapInformationCellViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Equatable
extension MapInformationCellViewModel: Equatable {
    static func == (lhs: MapInformationCellViewModel, rhs: MapInformationCellViewModel) -> Bool {
        return KeyPathEqualizer(lhs: lhs, rhs: rhs)
            .compare(by: \.id)
            .build()
    }
}
