//
//  CopyableViewModel.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import Foundation

public protocol CopyableViewModel {
    var copy: Self { get }
}

extension Array: CopyableViewModel where Element: CopyableViewModel {
    public var copy: [Element] {
        return map(\.copy)
    }
}
