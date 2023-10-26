//
//  BriefInformationCellViewModel.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

struct BriefInformationCellViewModel: BaseCellViewModel {
    var layout: BriefInformationCellViewLayout = .init()
    var id: String
    var date: String
    var image: String
    var temperature: String
    var size: CGSize = .zero
    
    init(
        layout: BriefInformationCellViewLayout = .init(),
        id: String,
        date: String,
        image: String,
        temperature: String
    ) {
        self.layout = layout
        self.id = id
        self.date = date
        self.image = image
        self.temperature = temperature
        calculateSize()
    }
    
    private mutating func calculateSize() {
        size = .init(
            width: [
                layout.contentInsets.horizontal,
                layout.imageHeight
            ].reduce(0, +),
            height: [
                layout.contentInsets.vertical,
                layout.imageHeight,
                layout.spacingBetweenImageAndValue,
                layout.spacingBetweenTitleAndImage,
                layout.valueFont.lineHeight,
                layout.titleFont.lineHeight
            ].reduce(0, +)
        )
    }
}

// MARK: - Hashable
extension BriefInformationCellViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Equatable
extension BriefInformationCellViewModel: Equatable {
    static func == (lhs: BriefInformationCellViewModel, rhs: BriefInformationCellViewModel) -> Bool {
        return KeyPathEqualizer(lhs: lhs, rhs: rhs)
            .compare(by: \.id)
            .compare(by: \.date)
            .compare(by: \.image)
            .compare(by: \.temperature)
            .build()
    }
}
