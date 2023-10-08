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
    var image: UIImage
    var temperature: String
    var size: CGSize = .zero
    
    init(layout: BriefInformationCellViewLayout = .init(), id: String, date: String, image: UIImage, temperature: String, width: CGFloat) {
        self.layout = layout
        self.id = id
        self.date = date
        self.image = image
        self.temperature = temperature
        calculateSize(width: width)
    }
    
    private mutating func calculateSize(width: CGFloat) {
        size = .init(width: width, height: layout.contentInsets.vertical + layout.imageHeight + layout.spacingBetweenImageAndValue + layout.spacingBetweenTitleAndImage + layout.valueFont.lineHeight + layout.titleFont.lineHeight)
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
