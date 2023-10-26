//
//   DirectionWindCollectionCell.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 10.10.2023.
//

import UIKit

class DirectionWindCollectionCell: UICollectionViewCell, Reusable {
    let source: DirectionWindCellView = .loadFromNib()

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

extension DirectionWindCollectionCell: ConfigurableCollectionCell {
    func configure(viewModel: DirectionWindCellViewModel) {
        source.configure(viewModel: viewModel)
    }
}
