//
//  NewRealeaseforCollectionViewCell.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 24/5/24.
//

import UIKit

class NewRealeaseforCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewRealeaseforCollectionViewCell"

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var backgroundforView: UIView!
    
    private var models : [NewReleaseCellViewModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Initialization code
    }
    public func configuareModel(models : [NewReleaseCellViewModel]){
        self.models = models
    }
    private func setupUI(){
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 10.0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.collectionViewLayout = layout
        let collection1 = UINib(nibName: "RecommendCollectionViewCell", bundle: nil)
        collectionView.register(collection1, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
        
    }
    
}
extension NewRealeaseforCollectionViewCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as? RecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configuareforNewReleaser(model: models[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = 10.0
        let width = ( collectionView.width - 2*spacing) / 2.3
        let height = width * 1.25
        return CGSize(width: width, height: height)
    }
    
    
}
