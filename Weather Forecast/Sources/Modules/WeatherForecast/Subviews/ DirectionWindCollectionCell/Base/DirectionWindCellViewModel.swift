//
//  DirectionWindCellViewModel.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 10.10.2023.
//

import Foundation

struct DirectionWindCellViewModel: BaseCellViewModel {
    var layout: DirectionWindCellViewLayout = .init()
    var id: String
    var title: String
    var direction: String
    var value: String
    var size: CGSize = .zero
    
    init(
        layout: DirectionWindCellViewLayout = .init(),
        id: String,
        title: String,
        direction: String,
        value: String,
        width: CGFloat
    ) {
        self.layout = layout
        self.id = id
        self.title = title
        self.value = value
        self.direction = direction
        calculateSize(width: width)
    }
    
    private mutating func calculateSize(width: CGFloat) {
        size = .init(width: width, height: width)
    }
}

// MARK: - Hashable
extension DirectionWindCellViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Equatable
extension DirectionWindCellViewModel: Equatable {
    static func == (lhs: DirectionWindCellViewModel, rhs: DirectionWindCellViewModel) -> Bool {
        return KeyPathEqualizer(lhs: lhs, rhs: rhs)
            .compare(by: \.id)
            .compare(by: \.title)
            .compare(by: \.direction)
            .compare(by: \.value)
            .build()
    }
}

