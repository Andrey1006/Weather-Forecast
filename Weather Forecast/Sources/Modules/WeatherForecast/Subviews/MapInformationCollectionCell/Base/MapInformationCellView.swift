//
//  MapInformationCellView.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit
import MapKit

final class MapInformationCellView: UIView, NibLoadable {
    @IBOutlet private weak var contentContainerView: UIView!
    @IBOutlet private weak var blurView: UIVisualEffectView!
    @IBOutlet private weak var mapView: MKMapView!
    
    private(set) var viewModel: MapInformationCellViewModel!
    let annotation = MKPointAnnotation()
    
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
        
        contentContainerView.backgroundColor = .clear
        contentContainerView.backgroundColor = contentContainerView.backgroundColor?.withAlphaComponent(0.2)
        contentContainerView.layer.cornerRadius = 12
        mapView.layer.cornerRadius = 8
        let coordinate: CLLocationCoordinate2D = .init(latitude: 50.43, longitude: 30.52)
        annotation.coordinate = CLLocationCoordinate2D(latitude: 50.43, longitude: 30.52)
        mapView.addAnnotation(annotation)
        mapView.setCenter(annotation.coordinate, animated: true)
        mapView.centerCoordinate = coordinate
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
    }
    
    func configure(viewModel: MapInformationCellViewModel) {
        self.viewModel = viewModel
        annotation.title = viewModel.currentLocationTemperature
    }
}

