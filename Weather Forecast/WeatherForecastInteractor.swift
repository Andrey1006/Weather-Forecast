//
//  WeatherForecastInteractor.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 20.09.2023.
//

import Foundation
import Alamofire

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

final class WeatherForecastInteractor {
    weak var presenter: WeatherForecastPresenterProtocol?
    
    func fetchData(
        completion: @escaping (Result<WeatherData, NetworkError>) -> Void
    ) {
        AF.request("https://api.weatherapi.com/v1/forecast.json?key=0b2d6edb40074e36b1595241231809&q=Kyiv&days=3")
            .responseDecodable(of: WeatherData.self) { result in
                print(result)
                switch result.result {
                case .success(let weatherData):
                    completion(.success(weatherData))
                case .failure(let error):
                    completion(.failure(.init(underlyingError: error)))
                }
            }
    }
}


struct DecodableDictionary<Value: Decodable>: Decodable {
    let source: [String: Value]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FlexibleCodingKey.self)
        
        self.source = container.allKeys.reduce(into: [:], { result, key in
            result[key.stringValue] = try? container.decode(Value.self, forKey: key)
        })
    }
}

struct FlexibleCodingKey: CodingKey {
    var stringValue: String
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init(key: String) {
        self.stringValue = key
    }
    
    // not implementedd
    var intValue: Int?
    init?(intValue: Int) {
        fatalError()
    }
}



extension Optional {
    // MARK: - Or
    public func or(_ valueBlock: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? valueBlock()
    }
    
    public func or(_ valueBlock: @autoclosure () -> Wrapped?) -> Self {
        return self ?? valueBlock()
    }
}
