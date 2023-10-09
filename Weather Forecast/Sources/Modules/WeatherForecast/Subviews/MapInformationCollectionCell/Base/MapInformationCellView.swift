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
        contentContainerView.backgroundColor = .gray
        contentContainerView.layer.cornerRadius = 12
        mapView.layer.cornerRadius = 8
        let ttest: CLLocationCoordinate2D = .init(latitude: 50.43, longitude: 30.52)
        mapView.centerCoordinate = ttest
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
    }
    
    func configure(viewModel: MapInformationCellViewModel) {
        self.viewModel = viewModel
    }
}

