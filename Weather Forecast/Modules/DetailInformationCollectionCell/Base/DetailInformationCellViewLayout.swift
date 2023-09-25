//
//  DetailInformationCellViewLayout.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

struct DetailInformationCellViewLayout {
    let outerContentInsets: UIEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 24)
    let innerContentInsets: UIEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
    let titleFont: UIFont = .systemFont(ofSize: 20)
    let minTemperatureFont: UIFont = .systemFont(ofSize: 20)
    let maxTemperatureFont: UIFont = .systemFont(ofSize: 20)
    let spacingBetweenTitleAndImage: CGFloat = 16
    let spacingBetweenImageAndValue: CGFloat = 16
    let imageHeight: CGFloat = 24
}
