//
//  WeatherForecastViewController.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 18.09.2023.
//

import UIKit
import Alamofire

protocol WeatherForecastViewControllerProtocol: AnyObject {
    func updateUI(weatherData: WeatherData)
    func showError(message: Error)
}

class WeatherForecastViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: WeatherForecastPresenterProtocol?
    
    var items: [BriefIInformationsCollectionViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(items)
        collectionView.registerCell(class: AttributesInformationCollectionCell.self)
        collectionView.registerCell(class: DetailInformationCollectionCell.self)
        collectionView.registerCell(class: BriefIInformationsCollectionCell.self)
        collectionView.registerCell(class: MapInformationCollectionCell.self)
        instantiate()
        
    }
}

extension WeatherForecastViewController: WeatherForecastViewControllerProtocol {
    func updateUI(weatherData: WeatherData) {
        for item in weatherData.forecast.forecastday {
            items = [.init(id: "1", items: [.init(id: "1", date: item.date, image: "", temperature: String(item.day.condition.text), width: 150), .init(id: "1", date: item.date, image: "", temperature: String(item.day.condition.text), width: 150), .init(id: "1", date: item.date, image: "", temperature: String(item.day.condition.text), width: 150)], width: view.bounds.width)]
        }
//        items = [.init(id: "1", title: "УФ-ИНДЕКС", value: String(weatherData.location.lat), explanation: weatherData.location.localtime, description: String(weatherData.location.localtime_epoch), width: self.view.bounds.width)]
        
        collectionView.reloadData()
    }
    
    func showError(message: Error) {
//        presenter?.didFailToFetchWeatherData(message)
        print("Ошибка: \(message.localizedDescription)")
    }
}

extension WeatherForecastViewController {
    func instantiate() {
        collectionView.backgroundColor = .blue
        collectionView.contentInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
}

extension WeatherForecastViewController: UICollectionViewDelegate {
    
}

extension WeatherForecastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: BriefIInformationsCollectionCell.self, for: indexPath)
        
        cell.configure(viewModel: items[indexPath.item])
        
        return cell
    }
}

extension WeatherForecastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return items[indexPath.item].size
    }
}




