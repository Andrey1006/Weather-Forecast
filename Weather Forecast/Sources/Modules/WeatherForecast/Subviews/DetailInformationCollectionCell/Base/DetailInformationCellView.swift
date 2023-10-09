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
    @IBOutlet weak var lineView: UIView!
    
    private(set) var viewModel: DetailInformationCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup() {
        lineView.backgroundColor = .black
    }
    
    func configure(viewModel: DetailInformationCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.date
        imageView.image = .init(systemName: viewModel.image)
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
    }
}
