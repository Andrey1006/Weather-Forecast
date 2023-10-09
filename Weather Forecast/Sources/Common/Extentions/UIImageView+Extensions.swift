//
//  UIImageView+Extensions.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 08.10.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(
        url: URL,
        placeholder: UIImage? = nil,
        // isSuccess: Bool
        completion: ((Bool) -> Void)? = nil
    ) {
        kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [.transition(.fade(0.3))],
            completionHandler: { result in
                switch result {
                case .success:
                    completion?(true)
                case .failure:
                    completion?(false)
                }
            }
        )
    }
    
    func cancelImageLoading() {
        kf.cancelDownloadTask()
    }
}
