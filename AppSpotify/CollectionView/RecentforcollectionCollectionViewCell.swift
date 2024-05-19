//
//  RecentforcollectionCollectionViewCell.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 16/5/24.
//

import UIKit

class RecentforcollectionCollectionViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "RecentforcollectionCollectionViewCell"
    
    
    private var cnt : Int?
    
    private var model :[RecentlyPlayedViewModels]?
    
    func configureNumberOfItem(number : Int){
        cnt = number
    }
    func configuareModel(model : [RecentlyPlayedViewModels]){
        self.model = model
    }
    @IBOutlet weak var maincollectionview: UICollectionView!
    
    private func setupUi(){
        
        let layout = UICollectionViewFlowLayout()
               layout.scrollDirection = .vertical
                
               layout.minimumLineSpacing = 10.0
               layout.minimumInteritemSpacing = 10.0
               layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) // Thêm khoảng cách lề trái và phải
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
//        guard let numberCnt = model?.count else {
//            return 0
//        }
//        if numberCnt < 2 {
//            return numberCnt
//        }
//        return 2
        return model?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyCollectionViewCell.identifier, for: indexPath) as? RecentlyCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = 10.0
        let width = ( collectionView.width - 2*spacing) / 2.0
        let height = width / 3.0
        return CGSize(width: width, height: height)
    }
    
}
