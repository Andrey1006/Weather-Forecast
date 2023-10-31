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
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    
    @IBOutlet weak var currentConditionImage: UIImageView!
    
    @IBOutlet weak var minAndMaxDayTemperature: UILabel!
    
    @IBOutlet private var conditionImages: [UIImageView]!
    
    @IBOutlet private weak var containerView: LineChartView!
    
    // MARK: - Properties
	var output: WeatherForecaseDetailsViewOutput!
    
    var viewModel: WeatherForecastDetailsViewModel!
    private lazy var dataSource: DetailsDataSource.DiffableDataSource = makeDataSource()
    
    var chartBackgroundLayer: CAShapeLayer = .init()
    var chartLineLayer: CAShapeLayer = .init()
    
    var indexOfDay: Int = 0

    // MARK: - Life cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        output.viewDidLoad()
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func makeDataSource() -> DetailsDataSource.DiffableDataSource {
        collectionView.registerCell(class: CalendarCollectionCell.self)
        
        let result: DetailsDataSource.DiffableDataSource = .init(for: collectionView) { collectionView, indexPath, cellViewModel in
            switch cellViewModel {
            case .dayOfTheWeek:
                return collectionView.dequeueReusableCell(
                    type: CalendarCollectionCell.self,
                    for: indexPath
                )
            }
        }
        
        return result
    }
}

// MARK: - Private methods
private extension WeatherForecaseDetailsViewController {
    func configure() {
        titleLabel.text = "🌡 Температура"
        collectionView.backgroundColor = .clear
        containerView.leftAxis.enabled = false
        containerView.rightAxis.setLabelCount(6, force: false)
        containerView.xAxis.labelPosition = .bottom
        containerView.pinchZoomEnabled = false
        containerView.doubleTapToZoomEnabled = false
        containerView.scaleXEnabled = false
        containerView.scaleYEnabled = false
        containerView.legend.enabled = false
        containerView.xAxis.labelTextColor = .lightGray
        containerView.rightAxis.labelTextColor = .lightGray
        
        collectionView.delegate = self
    }
}

// MARK: - WeatherForecaseDetailsViewProtocol
extension WeatherForecaseDetailsViewController: WeatherForecaseDetailsViewInput {
    func updateDataSource(weatherData: WeatherForecastDomainModel) {
        
        if indexOfDay == 0 {
            currentTemperatureLabel.text = "\(String(weatherData.currentHourWeather.temperature))°"
            currentConditionImage.setImage(url: URL(string: "https:\(weatherData.currentHourWeather.icon)")!)
            minAndMaxDayTemperature.text = "↓\(weatherData.forecast[indexOfDay].minTempereture)° ↑\(weatherData.forecast[indexOfDay].maxTempereture)°"
            
        } else {
            currentTemperatureLabel.text = "\(weatherData.forecast[indexOfDay].minTempereture)° \(weatherData.forecast[indexOfDay].maxTempereture)°"
            currentConditionImage.setImage(url: URL(string: "https:\(weatherData.forecast[indexOfDay].icon)")!)
            minAndMaxDayTemperature.text = "Градусы Цельсия (°С)"
            
        }

        for (index, image) in conditionImages.enumerated() {
            let interval = 2
            let selectedHour = index * interval

            if selectedHour < weatherData.forecast[indexOfDay].hourForecast.count {
                let item = weatherData.forecast[indexOfDay].hourForecast[selectedHour]
                image.setImage(url: URL(string: "https:\(item.icon)")!)
            }
        }


        
        let points: [ChartDataEntry] = weatherData.forecast[indexOfDay].hourForecast.enumerated().map { index, hour in
            return ChartDataEntry(x: .init(index), y: .init(hour.temperature))
        }
        let dataSet: LineChartDataSet = .init(entries: points, label: "")
        dataSet.drawCirclesEnabled = false
        dataSet.mode = .horizontalBezier
        dataSet.lineWidth = 2
        dataSet.setColor(.init(cgColor: .init(red: 123, green: 205, blue: 226, alpha: 1)))
        
        let data: LineChartData = .init(dataSet: dataSet)
        data.setDrawValues(false)
        
        containerView.data = data
    }
    
    func reloadDataSource() {
        self.dataSource.apply(viewModel.dataSource.snapshot, animatingDifferences: true)
    }
}

extension WeatherForecaseDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let itemViewModel: WeatherForecastDetailsKindCellViewModel = dataSource.itemViewModel(at: indexPath) else {
            return
        }
        self.indexOfDay = indexPath.item
        switch itemViewModel {
        case .dayOfTheWeek(let viewModel):
            cell.configure(as: CalendarCollectionCell.self, with: viewModel) { cell in
                cell.onTap = { [weak self] viewModel in
                    self?.output.didSelectDay(id: viewModel.id)
//                    self?.indexOfDay = indexPath.item
                    print(viewModel.id)
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WeatherForecaseDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return dataSource.insets(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource.itemSize(for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
