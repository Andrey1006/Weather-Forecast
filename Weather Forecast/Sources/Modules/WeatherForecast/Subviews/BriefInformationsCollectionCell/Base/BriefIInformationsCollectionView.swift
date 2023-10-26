//
//  BriefIInformationsCollectionView.swift
//  Weather Forecast
//
//  Created by Андрей Сторожко on 19.09.2023.
//

import UIKit

class BriefIInformationsCollectionView: UIView, NibLoadable {
    
    @IBOutlet private weak var contentContainerView: UIView!
    @IBOutlet private weak var blurView: UIVisualEffectView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private(set) var viewModel: BriefIInformationsCollectionViewModel!
    
    var onTap: ((BriefIInformationsCollectionViewModel) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup() {
        let blurEffect = UIBlurEffect(style: .light)
        blurView.effect = blurEffect
        blurView.alpha = 0.7
        blurView.layer.cornerRadius = 12
        blurView.layer.masksToBounds = true
        
        contentContainerView.backgroundColor = .clear
        contentContainerView.backgroundColor = collectionView.backgroundColor?.withAlphaComponent(0.2)
        contentContainerView.layer.cornerRadius = 12
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.cornerRadius = 12
        collectionView.registerCell(class: BriefInformationCollectionCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = .init(top: 0, left: 8, bottom: 0, right: 8)
        
        let tapGesture: UITapGestureRecognizer = .init()
        tapGesture.addTarget(self, action: #selector(didTapOnCell))
        addGestureRecognizer(tapGesture)
    }
    
    func configure(viewModel: BriefIInformationsCollectionViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
    @objc func didTapOnCell() {
        onTap?(viewModel)
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
        return 8
    }
}
