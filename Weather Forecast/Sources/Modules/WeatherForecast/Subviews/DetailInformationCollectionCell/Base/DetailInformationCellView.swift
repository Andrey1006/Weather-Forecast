//
//  DetailInformationCellView.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

final class DetailInformationCellView: UIView, NibLoadable {
    @IBOutlet private weak var outerContentContainerView: UIView!
    @IBOutlet private weak var blurView: UIVisualEffectView!
    @IBOutlet private weak var innerContentContainerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var minValueLabel: UILabel!
    @IBOutlet weak var lineValueView: UIView!
    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var outerContainerTopConstraint: NSLayoutConstraint!
    
    private(set) var viewModel: DetailInformationCellViewModel!
    
    var onTap: ((DetailInformationCellViewModel) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup() {
        outerContentContainerView.backgroundColor = .clear
        outerContentContainerView.backgroundColor = outerContentContainerView.backgroundColor?.withAlphaComponent(0.2)
        lineView.backgroundColor = .white
        lineView.backgroundColor = lineView.backgroundColor?.withAlphaComponent(0.5)
        
        let blurEffect = UIBlurEffect(style: .light)
        blurView.effect = blurEffect
        blurView.alpha = 0.7
        blurView.layer.masksToBounds = true
        
        let tapGesture: UITapGestureRecognizer = .init()
        tapGesture.addTarget(self, action: #selector(didTapOnCell))
        addGestureRecognizer(tapGesture)
    }
    
    func configure(viewModel: DetailInformationCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.date
        imageView.setImage(url: URL(string: viewModel.image)!)
        minValueLabel.text = viewModel.minTemperature
        maxValueLabel.text = viewModel.maxTemperature
        apply(layout: viewModel.layout)
    }

    private func apply(layout: DetailInformationCellViewLayout) {
        titleLabel.font = layout.titleFont
        minValueLabel.font = layout.minTemperatureFont
        maxValueLabel.font = layout.maxTemperatureFont
        lineView.isHidden = layout.viewIsHiden
        outerContentContainerView.layer.maskedCorners = layout.maskedCorners
        outerContentContainerView.layer.cornerRadius = layout.cornerRadius
        blurView.layer.maskedCorners = layout.maskedCorners
        blurView.layer.cornerRadius = layout.cornerRadius
        outerContainerTopConstraint.constant = layout.outerContentInsets.top
    }
    
    @objc func didTapOnCell() {
        onTap?(viewModel)
    }
}
