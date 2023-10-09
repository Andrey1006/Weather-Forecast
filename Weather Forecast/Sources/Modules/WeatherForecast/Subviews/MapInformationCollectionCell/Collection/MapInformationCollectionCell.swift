//
//  MapInformationCollectionCell.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

class MapInformationCollectionCell: UICollectionViewCell, Reusable {
    let source: MapInformationCellView = .loadFromNib()

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

extension MapInformationCollectionCell: ConfigurableCollectionCell {
    func configure(viewModel: MapInformationCellViewModel) {
        source.configure(viewModel: viewModel)
    }
}
