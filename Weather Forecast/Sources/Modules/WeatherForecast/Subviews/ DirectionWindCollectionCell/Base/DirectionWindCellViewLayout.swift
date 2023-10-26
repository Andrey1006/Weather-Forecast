//
//  DirectionWindCellViewLayout.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 10.10.2023.
//

import UIKit

struct DirectionWindCellViewLayout {
    let outerContentInsets: UIEdgeInsets = .init(top: 12, left: 24, bottom: 0, right: 24)
    let innerContentInsets: UIEdgeInsets = .init(top: 16, left: 16, bottom: 16, right: 16)
    
    let titleFont: UIFont = .systemFont(ofSize: 14)
    
    let spacingBetweenTitleAndValue: CGFloat = 12
}
