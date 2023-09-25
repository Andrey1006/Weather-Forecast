//
//  AttributesInformationCollectionCell.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

class AttributesInformationCollectionCell: UICollectionViewCell, Reusable {
    let source: AttributesInformationCellView = .loadFromNib()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialSetup()
    }
    
    private func initialSetup() {
       addConstrainted(subview: source)
    }
}

extension AttributesInformationCollectionCell: ConfigurableCollectionCell {
    func configure(viewModel: AttributesInformationCellViewModel) {
        source.configure(viewModel: viewModel)
    }
}
