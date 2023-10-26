//
//  WeatherForecastViewController.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 28.09.2023.
//

import UIKit

final class WeatherForecastViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var maxMinTemperatureLabel: UILabel!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // MARK: - Properties
	var output: WeatherForecastViewOutput!
    var viewModel: WeatherForecastViewModel!
    private lazy var dataSource: DataSource.DiffableDataSource = makeDataSource()
    
    
    // MARK: - Life cycle
	override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        output.viewDidLoad()
    }
}

// MARK: - Private methods
private extension WeatherForecastViewController {
    func configure() {
        viewModel.viewWidth = view.bounds.width
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        
        if traitCollection.userInterfaceStyle == .dark {
            backgroundImageView.image = UIImage(named: "noch")
        } else {
            backgroundImageView.image = UIImage(named: "solnce")
        }
    }
    
    func makeDataSource() -> DataSource.DiffableDataSource {
        collectionView.registerCell(class: TitleInformationCollectionCell.self)
        collectionView.registerCell(class: AttributesInformationCollectionCell.self)
        collectionView.registerCell(class: DetailInformationCollectionCell.self)
        collectionView.registerCell(class: BriefIInformationsCollectionCell.self)
        collectionView.registerCell(class: MapInformationCollectionCell.self)
        collectionView.registerCell(class: DirectionWindCollectionCell.self)
        
        let result: DataSource.DiffableDataSource = .init(for: collectionView) { collectionView, indexPath, cellViewModel in
            switch cellViewModel {
            case .title:
                return collectionView.dequeueReusableCell(
                    type: TitleInformationCollectionCell.self,
                    for: indexPath
                )
            case .brief:
                return collectionView.dequeueReusableCell(
                    type: BriefIInformationsCollectionCell.self,
                    for: indexPath
                )
            case .detail:
                return collectionView.dequeueReusableCell(
                    type: DetailInformationCollectionCell.self,
                    for: indexPath
                )
            case .map:
                return collectionView.dequeueReusableCell(
                    type: MapInformationCollectionCell.self,
                    for: indexPath
                )
            case .attributes:
                return collectionView.dequeueReusableCell(
                    type: AttributesInformationCollectionCell.self,
                    for: indexPath
                )
            case .directionWind:
                return collectionView.dequeueReusableCell(
                    type: DirectionWindCollectionCell.self,
                    for: indexPath
                )
            }
        }
        
        return result
    }
}

// MARK: - WeatherForecastViewProtocol
extension WeatherForecastViewController: WeatherForecastViewInput {
    func reloadDataSource() {
        self.dataSource.apply(viewModel.dataSource.snapshot, animatingDifferences: true)
    }
}

extension WeatherForecastViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let itemViewModel: WeatherForecastKindCellViewModel = dataSource.itemViewModel(at: indexPath) else {
            return
        }
        
        switch itemViewModel {
        case .title(let viewModel):
            cell.configure(as: TitleInformationCollectionCell.self, with: viewModel)
        case .brief(let viewModel):
            cell.configure(as: BriefIInformationsCollectionCell.self, with: viewModel) { cell in
                cell.onTap = { [weak self] viewModel in
                    self?.output.didTapOnDayCell(id: viewModel.id)
                    print(viewModel.id)
                }
            }
        case .detail(let viewModel):
            cell.configure(as: DetailInformationCollectionCell.self, with: viewModel) { cell in
                cell.onTap = { [weak self] viewModel in
                    self?.output.didTapOnDayCell(id: viewModel.id)
                    print(viewModel.id)
                }
            }
        case .map(let viewModel):
            cell.configure(as: MapInformationCollectionCell.self, with: viewModel)
        case .attributes(let viewModel):
            cell.configure(as: AttributesInformationCollectionCell.self, with: viewModel)
        case .directionWind(let viewModel):
            cell.configure(as: DirectionWindCollectionCell.self, with: viewModel)
        }
    }    
}


// MARK: - UICollectionViewDelegateFlowLayout
extension WeatherForecastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return dataSource.insets(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource.itemSize(for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return dataSource.interitemSpacing(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return dataSource.lineSpacing(for: section)
    }
}
