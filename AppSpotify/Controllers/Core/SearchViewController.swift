//
//  SearchViewController.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/6/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    private var models : [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        regis()
        setupUI()
    }
    
    private let colors : [UIColor] = [
        .systemRed,
        .systemOrange,
        .systemYellow,
        .systemPink,
        .systemTeal,
        .systemGreen,
        .systemBlue,
        .systemCyan,
        .systemMint,
        .systemBrown,
        .systemFill
        
    ]
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    // MARK: - Register collectionview Cell
    private func regis(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20.0
        layout.minimumInteritemSpacing = 10.0
        collectionView.collectionViewLayout = layout
        let cell1 = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        collectionView.register(cell1, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Register collectionview Cell
    private func setupUI(){
        profileImage.layer.cornerRadius = profileImage.height / 2
    }
    private func fetchData(){
        ApiCallerManager.shared.getCategories {[weak self] result in
            switch result{
            case .success(let model):
                DispatchQueue.main.async {
                    self!.models = model.categories.items
                    self!.collectionView.reloadData()
                }
                
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
extension SearchViewController : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = colors.randomElement()
        cell.configuareModel(model: models[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.width - 10) / 2.0
        let height = width * 31 / 55
        return CGSize(width: width, height: height)
    }
    
    
}
