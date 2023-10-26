//
//  BriefIInformationsCollectionCell.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

class BriefIInformationsCollectionCell: UICollectionViewCell, Reusable {
    let source: BriefIInformationsCollectionView = .loadFromNib()
    
    @Proxy(\BriefIInformationsCollectionCell.source.onTap)
    var onTap: ((BriefIInformationsCollectionViewModel) -> Void)?

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

extension BriefIInformationsCollectionCell: ConfigurableCollectionCell {
    func configure(viewModel: BriefIInformationsCollectionViewModel) {
        source.configure(viewModel: viewModel)
    }
}

