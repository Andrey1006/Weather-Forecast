//
//  DirectionWindCellView.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 10.10.2023.
//

import UIKit

final class DirectionWindCellView: UIView, NibLoadable {
    @IBOutlet private weak var outerContentContainerView: UIView!
    @IBOutlet private weak var blurView: UIVisualEffectView!
    @IBOutlet private weak var innerContentContainerView: UIView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var compassImageView: UIImageView!
    @IBOutlet private weak var arrowImageView: UIImageView!
    @IBOutlet private weak var valueContentView: UIView!
    @IBOutlet private weak var valueLabel: UILabel!
    
    private(set) var viewModel: DirectionWindCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup() {
        let blurEffect = UIBlurEffect(style: .light)
        blurView.effect = blurEffect
        blurView.alpha = 0.7
        blurView.layer.cornerRadius = 12
        blurView.layer.masksToBounds = true
        
        outerContentContainerView.backgroundColor = .clear
        outerContentContainerView.backgroundColor = outerContentContainerView.backgroundColor?.withAlphaComponent(0.2)
        compassImageView.image = .init(named: "compass")
        arrowImageView.image = .init(named: "arrow")
        outerContentContainerView.layer.cornerRadius = 12
        valueContentView.backgroundColor = .black
        valueContentView.layer.cornerRadius = 20
    }
    
    func configure(viewModel: DirectionWindCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
        if let windDirection = angleFromWindDirection(viewModel.direction) {
            let arrowAngle = windDirection
            rotateCompassArrow(arrowAngle)
        }
        apply(layout: viewModel.layout)
    }

    private func apply(layout: DirectionWindCellViewLayout) {
        titleLabel.font = layout.titleFont
    }
}

extension DirectionWindCellView {
    func rotateCompassArrow(_ angle: Double) {
        arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
    }
    
    func angleFromWindDirection(_ direction: String) -> Double? {
        let directionMap: [String: Double] = [
            "N": 0.0,
            "NNE": 22.5,
            "NE": 45.0,
            "ENE": 67.5,
            "E": 90.0,
            "ESE": 112.5,
            "SE": 135.0,
            "SSE": 157.5,
            "S": 180.0,
            "SSW": 202.5,
            "SW": 225.0,
            "WSW": 247.5,
            "W": 270.0,
            "WNW": 292.5,
            "NW": 315.0,
            "NNW": 337.5
        ]

        return directionMap[direction]
    }
}
