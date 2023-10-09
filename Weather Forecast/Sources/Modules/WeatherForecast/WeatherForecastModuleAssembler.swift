//
//  WeatherForecastModuleAssembler.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 28.09.2023.
//

import UIKit

final class WeatherForecastInitializator: NSObject {
    //Connect with object on storyboard
    // MARK: - IBOutlets
    @IBOutlet weak var viewController: WeatherForecastViewController!

    // MARK: - Life cycle
    override func awakeFromNib() {
        let assembler = WeatherForecastModuleAssembler()
        assembler.createModule(with: viewController)
    }
}

struct WeatherForecastModuleAssembler {
    // MARK: - Private methods
    func createModule(with viewController: WeatherForecastViewController) {
        let viewModel: WeatherForecastViewModel = .init()
        let interactor: WeatherForecastInteractor = .init()
        let router: WeatherForecastRouter = .init(viewController: viewController)
        let presenter: WeatherForecastPresenter = .init(
            view: viewController,
            viewModel: viewModel,
            interactor: interactor,
            router: router
        )
    
        viewController.viewModel = viewModel
        viewController.output = presenter
        interactor.output = presenter
    }
}
