//
//  BriefInformationCellView.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

final class BriefInformationCellView: UIView, NibLoadable {
    @IBOutlet weak var contentContainerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    
    private(set) var viewModel: BriefInformationCellViewModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup() {
        
    }
    
    func configure(viewModel: BriefInformationCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.date
        imageView.setImage(url: URL(string: viewModel.image)!)
        valueLabel.text = viewModel.temperature
        apply(layout: viewModel.layout)
    }

    private func apply(layout: BriefInformationCellViewLayout) {
        titleLabel.font = layout.titleFont
        valueLabel.font = layout.valueFont
    }
}

