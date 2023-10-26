//
//  CalendarCollectionCell.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 13.10.2023.
//

import UIKit

class CalendarCollectionCell: UICollectionViewCell, Reusable {
    let source: CalendarCellView = .loadFromNib()
    
    @Proxy(\CalendarCollectionCell.source.onTap)
    var onTap: ((CalendarCellViewModel) -> Void)?

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

extension CalendarCollectionCell: ConfigurableCollectionCell {
    func configure(viewModel: CalendarCellViewModel) {
        source.configure(viewModel: viewModel)
    }
}
