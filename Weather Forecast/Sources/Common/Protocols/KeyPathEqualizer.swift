//
//  KeyPathEqualizer.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 26.09.2023.
//

import Foundation

public final class KeyPathEqualizer<Object> {
    private let lhs: Object
    private let rhs: Object
    
    private var areEqual: Bool = true
    
    public init(lhs: Object, rhs: Object) {
        self.lhs = lhs
        self.rhs = rhs
    }
    
    public func compare<T: Equatable>(by keyPath: KeyPath<Object, T>) -> Self {
        guard areEqual else {
            return self
        }
        
        if lhs[keyPath: keyPath] != rhs[keyPath: keyPath] {
            areEqual = false
        }
        
        return self
    }
    
    public func build() -> Bool {
        return areEqual
    }
}
