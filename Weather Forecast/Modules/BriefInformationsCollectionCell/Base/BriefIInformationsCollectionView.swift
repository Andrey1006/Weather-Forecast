//
//  BriefIInformationsCollectionView.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

class BriefIInformationsCollectionView: UIView, NibLoadable {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private(set) var viewModel: BriefIInformationsCollectionViewModel!
        
        
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.contentInset = .init(top: 0, left: 8, bottom: 0, right: 8)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerCell(class: BriefInformationCollectionCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .gray
    }
    
    func configure(viewModel: BriefIInformationsCollectionViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
}

extension BriefIInformationsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension BriefIInformationsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            type: BriefInformationCollectionCell.self,
            for: indexPath
        )
        
        cell.configure(viewModel: viewModel.items[indexPath.item])
        
        return cell
    }
}

extension BriefIInformationsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.items[indexPath.item].size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
//        return viewModel.layout.spacingBetweenItems
    }
}
