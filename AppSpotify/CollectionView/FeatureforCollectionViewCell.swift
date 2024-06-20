//
//  FeatureforCollectionViewCell.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 28/5/24.
//

import UIKit

class FeatureforCollectionViewCell: UICollectionViewCell {

    static let identifier = "FeatureforCollectionViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var model : NewFeatureCellModel?
    
    private func setupUI(){
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 10.0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.collectionViewLayout = layout
        let collection1 = UINib(nibName: "FullHeightCollectionViewCell", bundle: nil)
        collectionView.register(collection1, forCellWithReuseIdentifier: FullHeightCollectionViewCell.identifier)
    }
    
    func configuareModel(model : NewFeatureCellModel){
        self.model = model
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Initialization code
    }

}
extension FeatureforCollectionViewCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FullHeightCollectionViewCell.identifier, for: indexPath) as? FullHeightCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let model = model {
            cell.configuareModel(model: model)
        }
        
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.height
        let width = collectionView.width
        return CGSize(width: width, height: height)
    }
    
}
