//
//  BriefInformationCollectionCell.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

class BriefInformationCollectionCell: UICollectionViewCell, Reusable {
    let source: BriefInformationCellView = .loadFromNib()

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

extension BriefInformationCollectionCell: ConfigurableCollectionCell {
    func configure(viewModel: BriefInformationCellViewModel) {
        source.configure(viewModel: viewModel)
    }
}
