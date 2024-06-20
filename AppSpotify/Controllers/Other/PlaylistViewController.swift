//
//  PlaylistViewController.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 15/6/24.
//

import UIKit

class PlaylistViewController: UIViewController {
    
    @IBOutlet weak var contentview: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var bottomView: UIView!
    private var models: [PlayListTrackObject] = []
    
    @IBOutlet weak var imagePlaylist: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageSong: UIImageView!
    @IBOutlet weak var plusSong: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var downloadSong: UIButton!
    
    @IBOutlet weak var playButton: UIImageView!
    
    @IBOutlet weak var randomSongButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        fetchData()
        registerCollectionView()
        self.view.layoutIfNeeded()
        // Do any additional setup after loading the view.
    }
    
    private func registerCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cell1 = UINib(nibName: "PlaylistCollectionViewCell", bundle: nil)
        collectionView.register(cell1, forCellWithReuseIdentifier: PlaylistCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupUI() {
        addGradientToView(view: container)
        imageSong.layer.cornerRadius = 8.0
        imageSong.layer.masksToBounds = true
        imageSong.layer.borderWidth = 2
        imageSong.layer.borderColor = UIColor.white.cgColor
    }
    
    private func addGradientToView(view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        // Set the start and end colors
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor.black.cgColor // Màu đen
        ]
        
        gradientLayer.locations = [
            NSNumber(value: 0.0),
            NSNumber(value: 0.5)
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func fetchData() {
        ApiCallerManager.shared.getDetailPlaylist(playlistId: "3cEYpjA9oz9GiPac4AsH4n") { result in
            switch result {
            case .success(let models):
                DispatchQueue.main.async {
                    self.models = models.tracks.items
                    self.collectionView.reloadData()
                    self.updateCollectionViewHeight() // Gọi phương thức để cập nhật chiều cao
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCollectionViewHeight() // Cập nhật chiều cao của UICollectionView
    }
    
    private func updateCollectionViewHeight() {
        self.collectionViewHeightConstraint.constant = self.collectionView.contentSize.height
        self.view.layoutIfNeeded()
    }
}

// MARK: - EXTENSION

extension PlaylistViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistCollectionViewCell.identifier, for: indexPath) as? PlaylistCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configuareModel(model: models[indexPath.row].track)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = self.view.frame.height / 11
        return CGSize(width: width, height: height)
    }
}
