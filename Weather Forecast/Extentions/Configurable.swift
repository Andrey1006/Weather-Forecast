//
//  Configurable.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

// MARK: - Cell
public protocol ConfigurableCollectionCell {
    associatedtype ViewModel: BaseCellViewModel
    func configure(viewModel: ViewModel)
}

public extension UICollectionViewCell {
    func configure<Cell: UICollectionViewCell, ViewModel>(
        as cellType: Cell.Type,
        with viewModel: ViewModel,
        andApply modification: ((Cell) -> Void)? = nil
    ) where Cell: ConfigurableCollectionCell, Cell.ViewModel == ViewModel {
        guard let cell = self as? Cell else {
            assertionFailure("Failed to cast cell of type \(Self.self) to \(cellType)")
            return
        }
        
        modification?(cell)
        cell.configure(viewModel: viewModel)
    }
}

public protocol ConfigurableTableCell {
    associatedtype ViewModel: BaseCellViewModel
    func configure(viewModel: ViewModel)
}

public extension UITableViewCell {
    func configure<Cell: UITableViewCell, ViewModel>(
        as cellType: Cell.Type,
        with viewModel: ViewModel,
        andApply modification: ((Cell) -> Void)? = nil
    ) where Cell: ConfigurableTableCell, Cell.ViewModel == ViewModel {
        guard let cell = self as? Cell else {
            assertionFailure("Failed to cast cell of type \(Self.self) to \(cellType)")
            return
        }
        
        modification?(cell)
        cell.configure(viewModel: viewModel)
    }
}

// MARK: - Header
public protocol ConfigurableCollectionHeader {
    associatedtype ViewModel: BaseHeaderViewModel
    func configure(viewModel: ViewModel)
}

public extension UICollectionReusableView {
    func configure<View: UICollectionReusableView, ViewModel>(
        as viewType: View.Type,
        with viewModel: ViewModel,
        andApply modification: ((View) -> Void)? = nil
    ) where View: ConfigurableCollectionHeader, View.ViewModel == ViewModel {
        guard let view = self as? View else {
            assertionFailure("Failed to cast header reusable view of type \(Self.self) to \(viewType)")
            return
        }
        
        modification?(view)
        view.configure(viewModel: viewModel)
    }
}

// MARK: - Footer
public protocol ConfigurableCollectionFooter {
    associatedtype ViewModel: BaseFooterViewModel
    func configure(viewModel: ViewModel)
}

public extension UICollectionReusableView {
    func configure<View: UICollectionReusableView, ViewModel>(
        as viewType: View.Type,
        with viewModel: ViewModel,
        andApply modification: ((View) -> Void)? = nil
    ) where View: ConfigurableCollectionFooter, View.ViewModel == ViewModel {
        guard let view = self as? View else {
            assertionFailure("Failed to cast footer reusable view of type \(Self.self) to \(viewType)")
            return
        }
        
        modification?(view)
        view.configure(viewModel: viewModel)
    }
}
