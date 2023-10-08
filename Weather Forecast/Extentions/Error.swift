//
//  Error.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 26.09.2023.
//

import Foundation

struct NetworkError: Error {
    let underlyingError: Error?
}

extension Result where Failure == NetworkError {
    static var failure: Self {
        return .failure(nil)
    }
    
    static func failure(_ error: Error?) -> Self {
        return .failure(.init(underlyingError: error))
    }
}
