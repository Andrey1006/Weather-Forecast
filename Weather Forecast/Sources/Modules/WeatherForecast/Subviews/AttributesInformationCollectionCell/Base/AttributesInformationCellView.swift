//
//  AttributesInformationCellView.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

final class AttributesInformationCellView: UIView, NibLoadable {
    @IBOutlet weak var outerContentContainerView: UIView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var innerContentContainerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    private(set) var viewModel: AttributesInformationCellViewModel!
    
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
    }
    
    func configure(viewModel: AttributesInformationCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
        outerContentContainerView.layer.cornerRadius = 12
        apply(layout: viewModel.layout)
    }

    private func apply(layout: AttributesInformationCellViewLayout) {
        titleLabel.font = layout.titleFont
        valueLabel.font = layout.valueFont
    }
}
