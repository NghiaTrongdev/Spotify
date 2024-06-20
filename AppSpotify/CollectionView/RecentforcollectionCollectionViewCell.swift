//
//  RecentforcollectionCollectionViewCell.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 16/5/24.
//

import UIKit
protocol RecentforcollectionCollectionViewCellDelegate : AnyObject {
    
}
class RecentforcollectionCollectionViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "RecentforcollectionCollectionViewCell"
    private var models : [RecentlyPlayedViewModels] = []
    
    func configuareModel(models : [RecentlyPlayedViewModels]){
        self.models = models
        
                
    }
    @IBOutlet weak var maincollectionview: UICollectionView!
    
    private func setupUi(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10) // Thêm khoảng cách lề trái và phải
        maincollectionview.collectionViewLayout = layout
        
        let collection1 = UINib(nibName: "RecentlyCollectionViewCell", bundle: nil)
        maincollectionview.register(collection1, forCellWithReuseIdentifier: RecentlyCollectionViewCell.identifier)
        maincollectionview.dataSource = self
        maincollectionview.delegate = self
        maincollectionview.isScrollEnabled = false
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUi()
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        
        return models.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyCollectionViewCell.identifier, for: indexPath) as? RecentlyCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let model = models[indexPath.row]
        cell.configuareModel(model: model)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.width - 10.0) / 2.0
        let height = width / 3.0
        return CGSize(width: width, height: height)
    }
    
}
