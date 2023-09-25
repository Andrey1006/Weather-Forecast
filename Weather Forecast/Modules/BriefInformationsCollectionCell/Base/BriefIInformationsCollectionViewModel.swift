//
//  BriefIInformationsCollectionViewModel.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import Foundation

struct BriefIInformationsCollectionViewModel: BaseCellViewModel {
    var layout: BriefIInformationsCollectionViewLayout = .init()
    var id: String
    var items: [BriefInformationCellViewModel]
    var size: CGSize = .zero
    
    init(layout: BriefIInformationsCollectionViewLayout = .init(), id: String, items: [BriefInformationCellViewModel], width: CGFloat) {
        self.layout = layout
        self.id = id
        self.items = items
        calculateSize(width: width)
    }
    
    private mutating func calculateSize(width: CGFloat) {
        size = .init(width: width, height: 150)
    }
}

// MARK: - Hashable
extension BriefIInformationsCollectionViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Equatable
extension BriefIInformationsCollectionViewModel: Equatable {
    static func == (
        lhs: BriefIInformationsCollectionViewModel,
        rhs: BriefIInformationsCollectionViewModel
    )-> Bool {
        return true
    }
}
