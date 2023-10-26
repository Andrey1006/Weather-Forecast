//
//  CalendarCellViewLayout.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 23.10.2023.
//

import UIKit

struct CalendarCellViewLayout {
    let contentInsets: UIEdgeInsets = .init(top: 8, left: 0, bottom: 8, right: 0)
    let dayOfTheWeekFont: UIFont = .systemFont(ofSize: 12)
    let dateFont: UIFont = .systemFont(ofSize: 17)
    let spacingBetweenDayOfTheWeekAndDate: CGFloat = 4
    let dateContaierHeight: CGFloat = 40
}
