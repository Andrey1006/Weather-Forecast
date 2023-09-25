//
//  MapInformationCellView.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit
import MapKit

final class MapInformationCellView: UIView, NibLoadable {
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    private(set) var viewModel: MapInformationCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup() {
        contentContainerView.layer.cornerRadius = 12
        mapView.layer.cornerRadius = 8
    }
    
    func configure(viewModel: MapInformationCellViewModel) {
        self.viewModel = viewModel
    }
}

