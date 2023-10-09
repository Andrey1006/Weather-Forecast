//
//  AttributesInformationCellViewModel.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import Foundation

struct AttributesInformationCellViewModel: BaseCellViewModel {
    var layout: AttributesInformationCellViewLayout = .init()
    var id: String
    var title: String
    var value: String
    var explanation: String
    var description: String
    var size: CGSize = .zero
    
    init(layout: AttributesInformationCellViewLayout = .init(), id: String = "", title: String = "", value: String = "", explanation: String = "", description: String = "", width: CGFloat) {
        self.layout = layout
        self.id = id
        self.title = title
        self.value = value
        self.explanation = explanation
        self.description = description
        calculateSize(width: width)
    }
    
    private mutating func calculateSize(width: CGFloat) {
        size = .init(width: width, height: width)
    }
}

// MARK: - Hashable
extension AttributesInformationCellViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Equatable
extension AttributesInformationCellViewModel: Equatable {
    static func == (lhs: AttributesInformationCellViewModel, rhs: AttributesInformationCellViewModel) -> Bool {
        return KeyPathEqualizer(lhs: lhs, rhs: rhs)
            .compare(by: \.id)
            .compare(by: \.title)
            .compare(by: \.value)
            .compare(by: \.explanation)
            .compare(by: \.description)
            .build()
    }
}
