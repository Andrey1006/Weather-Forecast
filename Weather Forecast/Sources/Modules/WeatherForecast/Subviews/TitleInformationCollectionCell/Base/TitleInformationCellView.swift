//
//  TitleInformationCellView.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 11.10.2023.
//

import UIKit

final class TitleInformationCellView: UIView, NibLoadable {
    @IBOutlet weak var outerContentContainerView: UIView!
    @IBOutlet weak var innerContentContainerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var weatherPhenomenonLabel: UILabel!
    @IBOutlet weak var maxAndMinTemperatureLabel: UILabel!
    
    private(set) var viewModel: TitleInformationCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup() {
        
    }
    
    func configure(viewModel: TitleInformationCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
        weatherPhenomenonLabel.text = viewModel.weatherPhenomenon
        maxAndMinTemperatureLabel.text = viewModel.maxAndMinTemperature
    }
}

