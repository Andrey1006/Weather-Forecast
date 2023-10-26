//
//  CalendarCellViewModel.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 13.10.2023.
//

import UIKit

struct CalendarCellViewModel: BaseCellViewModel {
    var layout: CalendarCellViewLayout
    var id: String
    var dayOfTheWeek: String
    var date: String
    var isSelected: Bool
    var size: CGSize = .zero
    
    init(
        layout: CalendarCellViewLayout = .init(),
        id: String,
        dayOfTheWeek: String,
        date: String,
        isSelected: Bool = false
    ) {
        self.layout = layout
        self.id = id
        self.dayOfTheWeek = dayOfTheWeek
        self.date = date
        self.isSelected = isSelected
        calculateSize()
    }
    
    private mutating func calculateSize() {
        size = .init(
            width: 40,
            height: 82
        )
    }
}

// MARK: - Hashable
extension CalendarCellViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Equatable
extension CalendarCellViewModel: Equatable {
    static func == (lhs: CalendarCellViewModel, rhs: CalendarCellViewModel) -> Bool {
        return KeyPathEqualizer(lhs: lhs, rhs: rhs)
            .compare(by: \.id)
            .compare(by: \.dayOfTheWeek)
            .compare(by: \.date)
            .compare(by: \.isSelected)
            .build()
    }
}
