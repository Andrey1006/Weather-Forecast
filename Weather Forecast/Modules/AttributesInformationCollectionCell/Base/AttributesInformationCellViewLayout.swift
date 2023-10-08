//
//  AttributesInformationCellViewLayout.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

struct AttributesInformationCellViewLayout {
    let outerContentInsets: UIEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 24)
    let innerContentInsets: UIEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
    
    let titleFont: UIFont = .systemFont(ofSize: 14)
    let valueFont: UIFont = .systemFont(ofSize: 24)
    let explanationFont: UIFont = .systemFont(ofSize: 20)
    let descriptionFont: UIFont = .systemFont(ofSize: 17)
    
    let spacingBetweenTitleAndValue: CGFloat = 24
    let spacingBetweenValueAndExplanation: CGFloat = 16
}
