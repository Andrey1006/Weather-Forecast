//
//  WeatherForecastModuleAssembler.swift
//  Weather Forecast
//
//  Created Андрей Сторожко on 28.09.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
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
        let router: WeatherForecastRouter = .init()
        let presenter: WeatherForecastPresenter = .init(
            view: viewController,
            viewModel: viewModel,
            interactor: interactor,
            router: router
        )
    
        viewController.viewModel = viewModel
        viewController.output = presenter
        viewController.moduleInput = presenter
        interactor.output = presenter
        router.viewController = viewController
    }
}
