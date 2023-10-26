//
//  DetailInformationCollectionCell.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//
import UIKit

class DetailInformationCollectionCell: UICollectionViewCell, Reusable {
    let source: DetailInformationCellView = .loadFromNib()
    
    @Proxy(\DetailInformationCollectionCell.source.onTap)
    var onTap: ((DetailInformationCellViewModel) -> Void)?

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

extension DetailInformationCollectionCell: ConfigurableCollectionCell {
    func configure(viewModel: DetailInformationCellViewModel) {
        source.configure(viewModel: viewModel)
    }
}
