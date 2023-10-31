//
//  CalendarCellView.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 13.10.2023.
//

import UIKit

final class CalendarCellView: UIView, NibLoadable {
    @IBOutlet weak var contentContainerView: UIView!
    
    @IBOutlet weak var dateContaierView: UIView!
    @IBOutlet weak var dayOfTheWeekLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private(set) var viewModel: CalendarCellViewModel!
    
    var onTap: ((CalendarCellViewModel) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup() {
        let tapGesture: UITapGestureRecognizer = .init()
        tapGesture.addTarget(self, action: #selector(didTapOnCell))
        addGestureRecognizer(tapGesture)
    }
    
    func configure(viewModel: CalendarCellViewModel) {
        self.viewModel = viewModel
        dayOfTheWeekLabel.text = viewModel.dayOfTheWeek
        dateLabel.text = viewModel.date
        if viewModel.isSelected {
            dateContaierView.backgroundColor = .blue
        } else {
            dateContaierView.backgroundColor = .clear
        }
        apply(layout: viewModel.layout)
    }
    
    private func apply(layout: CalendarCellViewLayout) {
        dayOfTheWeekLabel.font = layout.dayOfTheWeekFont
        dateLabel.font = layout.dateFont
        dateContaierView.layer.cornerRadius = layout.dateContaierHeight / 2
    }
    
    @objc func didTapOnCell() {
        onTap?(viewModel)
    }
}
