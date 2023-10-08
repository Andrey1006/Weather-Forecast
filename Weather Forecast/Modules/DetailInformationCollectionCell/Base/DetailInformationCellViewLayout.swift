//
//  DetailInformationCellViewLayout.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

struct DetailInformationCellViewLayout {
    let outerContentInsets: UIEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 24)
    let innerContentInsets: UIEdgeInsets
    let titleFont: UIFont = .systemFont(ofSize: 20)
    let minTemperatureFont: UIFont = .systemFont(ofSize: 20)
    let maxTemperatureFont: UIFont = .systemFont(ofSize: 20)
    let spacingBetweenTitleAndImage: CGFloat = 16
    let spacingBetweenImageAndValue: CGFloat = 16
    let imageHeight: CGFloat = 24
    let cornerRadius: CGFloat
    var maskedCorners: CACornerMask
    var viewIsHiden: Bool = false
    
    init(roundStrategy: RoundedSectionItemKind) {
        let innerBaseContentInset: UIEdgeInsets = .init(top: 16, left: 16, bottom: 16, right: 16)
        let baseCornerRadius: CGFloat = 12
        
        switch roundStrategy {
        case .first:
            cornerRadius = baseCornerRadius
            maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            innerContentInsets = .init(
                top: innerBaseContentInset.top,
                left: innerBaseContentInset.left,
                bottom: innerBaseContentInset.bottom / 2,
                right: innerBaseContentInset.right
            )
            viewIsHiden = true
        case .middle:
            cornerRadius = 0
            maskedCorners = []
            innerContentInsets = .init(
                top: innerBaseContentInset.top / 2,
                left: innerBaseContentInset.left,
                bottom: innerBaseContentInset.bottom / 2,
                right: innerBaseContentInset.right
            )
            viewIsHiden = false
        case .last:
            cornerRadius = baseCornerRadius
            maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            innerContentInsets = .init(
                top: innerBaseContentInset.top / 2,
                left: innerBaseContentInset.left,
                bottom: innerBaseContentInset.bottom,
                right: innerBaseContentInset.right
            )
            viewIsHiden = false
        case .single:
            cornerRadius = baseCornerRadius
            maskedCorners = [
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner,
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner
            ]
            innerContentInsets = .init(
                top: innerBaseContentInset.top,
                left: innerBaseContentInset.left,
                bottom: innerBaseContentInset.bottom,
                right: innerBaseContentInset.right
            )
            viewIsHiden = false
        }
    }
}
