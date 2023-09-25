//
//  DetailInformationCellView.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

final class DetailInformationCellView: UIView, NibLoadable {
    @IBOutlet weak var outerContentContainerView: UIView!
    @IBOutlet weak var innerContentContainerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var minValueLabel: UILabel!
    @IBOutlet weak var lineValueView: UIView!
    @IBOutlet weak var maxValueLabel: UILabel!
    
    private(set) var viewModel: DetailInformationCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup() {
        
    }
    
    func configure(viewModel: DetailInformationCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.date
        minValueLabel.text = viewModel.minTemperature
        maxValueLabel.text = viewModel.maxTemperature
        apply(layout: viewModel.layout)
    }

    private func apply(layout: DetailInformationCellViewLayout) {
        titleLabel.font = layout.titleFont
    }
}
