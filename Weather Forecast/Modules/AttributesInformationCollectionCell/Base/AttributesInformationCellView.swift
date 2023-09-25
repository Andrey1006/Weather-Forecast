//
//  AttributesInformationCellView.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

final class AttributesInformationCellView: UIView, NibLoadable {
    @IBOutlet weak var outerContentContainerView: UIView!
    @IBOutlet weak var innerContentContainerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private(set) var viewModel: AttributesInformationCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup() {
        
    }
    
    func configure(viewModel: AttributesInformationCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
        explanationLabel.text = viewModel.explanation
        descriptionLabel.text = viewModel.description

        apply(layout: viewModel.layout)
    }

    private func apply(layout: AttributesInformationCellViewLayout) {
        titleLabel.font = layout.titleFont
        valueLabel.font = layout.valueFont
        explanationLabel.font = layout.explanationFont
        descriptionLabel.font = layout.descriptionFont
    }
}
