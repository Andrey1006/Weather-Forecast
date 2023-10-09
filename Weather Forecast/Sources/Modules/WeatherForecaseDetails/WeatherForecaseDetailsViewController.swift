//
//  WeatherForecaseDetailsViewController.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 08.10.2023.
//

import UIKit
import Charts
import DGCharts

final class WeatherForecaseDetailsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: LineChartView!
    
    // MARK: - Properties
	var output: WeatherForecaseDetailsViewOutput!

    // MARK: - Life cycle
	override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    var chartBackgroundLayer: CAShapeLayer = .init()
    var chartLineLayer: CAShapeLayer = .init()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        output.viewDidLoad()
    }
}

// MARK: - Private methods
private extension WeatherForecaseDetailsViewController {
    func configure() {

        containerView.leftAxis.enabled = false
        containerView.rightAxis.setLabelCount(6, force: false)
        containerView.xAxis.labelPosition = .bottom
        containerView.pinchZoomEnabled = false
        containerView.doubleTapToZoomEnabled = false
        containerView.scaleXEnabled = false
        containerView.scaleYEnabled = false
        containerView.legend.enabled = false
    }
}

// MARK: - WeatherForecaseDetailsViewProtocol
extension WeatherForecaseDetailsViewController: WeatherForecaseDetailsViewInput {
    func updateDataSource(weatherData: WeatherForecastDomainModel) {
        let points: [ChartDataEntry] = weatherData.forecast[0].hourForecast.enumerated().map { index, hour in
            return ChartDataEntry(x: .init(index), y: .init(hour.temperature))
        }
        let dataSet: LineChartDataSet = .init(entries: points, label: "")
        dataSet.drawCirclesEnabled = false
        dataSet.mode = .horizontalBezier
        
        let data: LineChartData = .init(dataSet: dataSet)
        data.setDrawValues(false)
        
        containerView.data = data
    }
}
