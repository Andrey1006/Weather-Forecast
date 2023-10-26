//
//  TitleInformationCollectionCell.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 11.10.2023.
//

import UIKit

class TitleInformationCollectionCell: UICollectionViewCell, Reusable {
    let source: TitleInformationCellView = .loadFromNib()

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

extension TitleInformationCollectionCell: ConfigurableCollectionCell {
    func configure(viewModel: TitleInformationCellViewModel) {
        source.configure(viewModel: viewModel)
    }
}
