//
//  LibraryViewController.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 7/6/24.
//

import UIKit
enum TypeLibrarySection {
    case Artist( models : [ArtistResponse])
    case Playlist ( models : [PlayList])
    case Bottom
}

class LibraryViewController: UIViewController {
    private var sections : [TypeLibrarySection] = []
    
    private var imageChanged : Bool = true
    private var collectionViewtype : Bool = true

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var artistButton: UIButton!
    
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var typeButton: UIButton!
    
    @IBAction func plusButtonOnclick(_ sender: Any) {
        let vc = PreviewLibraryViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.view.frame = CGRect(x: 0, y: view.height, width: view.width, height: view.height)
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        UIView.animate(withDuration: 0.3) {
            vc.view.frame = CGRect(x: 0, y: 0, width:self.view.width, height: self.view.height)
        }
    }
    @IBAction func listButtonOnclick(_ sender: Any) {
        
    }

    @IBAction func artistButtonOnclick(_ sender: Any) {
        
    }
    
    @IBAction func typeButtonOnClick(_ sender: Any) {
        
        if imageChanged {
            typeButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        } else {
            typeButton.setImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
            
        }
        imageChanged.toggle()
        collectionViewtype.toggle()
        collectionView.reloadData()
    }
    // MARK: - REGISTER COLLECTIONVIEW CELL
    
    private func initCollectionView(){
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        
        let collection1 = UINib(nibName: "BottomTypeGridCollectionViewCell", bundle: nil)
        let collection2 = UINib(nibName: "BottomTypeListCollectionViewCell", bundle: nil)
        let collection3 = UINib(nibName: "ArtistListCollectionViewCell", bundle: nil)
        let collection4 = UINib(nibName: "ArtistCollectionViewCell", bundle: nil)
        let collection5 = UINib(nibName: "PlaylistGridCollectionViewCell", bundle: nil)
        let collection6 = UINib(nibName: "PlaylistListCollectionViewCell", bundle: nil)
        
        collectionView.register(collection1, forCellWithReuseIdentifier: BottomTypeGridCollectionViewCell.identifier)
        collectionView.register(collection2, forCellWithReuseIdentifier: BottomTypeListCollectionViewCell.identifier)
        collectionView.register(collection3, forCellWithReuseIdentifier: ArtistListCollectionViewCell.identifier)
        collectionView.register(collection4, forCellWithReuseIdentifier: ArtistCollectionViewCell.identifier)
        collectionView.register(collection5, forCellWithReuseIdentifier: PlaylistGridCollectionViewCell.identifier)
        collectionView.register(collection6, forCellWithReuseIdentifier: PlaylistListCollectionViewCell.identifier)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    private func fetchData(){
        
        let group = DispatchGroup()
        group.enter()
        group.enter()
         
        
        var artist : getSomeArtistResponse?
        var playlist : UserPlayListResponse?
        

        ApiCallerManager.shared.getSomeArtist {result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let models):
                artist = models
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        ApiCallerManager.shared.getUserPlaylist { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let models):
                playlist = models
                
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.notify(queue: .main){
            guard let artistmodels = artist?.artists else {
                return
            }
            guard let playlistmodels = playlist?.items else {
                return
            }
            self.sections.append(.Artist(models: artistmodels))
            self.sections.append(.Playlist(models: playlistmodels))
            self.sections.append(.Bottom)
            self.collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        profileImage.layer.cornerRadius = profileImage.height / 2.0
        profileImage.layer.masksToBounds = true
        profileImage.clipsToBounds = true
        fetchData()
        initCollectionView()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }


}
extension LibraryViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = sections[section]
        switch model{
        case .Artist(let models ):
            return models.count
        case.Playlist(let models ):
            return models.count
        case .Bottom:
            return 1
        }
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = sections[indexPath.section]
        switch model{
        case.Artist(let models):
            if collectionViewtype {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistCollectionViewCell.identifier, for: indexPath) as? ArtistCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configuareModel(artist: models[indexPath.row])
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistListCollectionViewCell.identifier, for: indexPath) as? ArtistListCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configuareModel(artist: models[indexPath.row])
                return cell
            }
            
            
        case.Playlist(let models):
            if collectionViewtype {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistGridCollectionViewCell.identifier, for: indexPath) as? PlaylistGridCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configuareModel(model: models[indexPath.row])
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistListCollectionViewCell.identifier, for: indexPath) as? PlaylistListCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configuareModel(model: models[indexPath.row])
                return cell
            }
        case .Bottom:
            if collectionViewtype {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomTypeGridCollectionViewCell.identifier, for: indexPath) as? BottomTypeGridCollectionViewCell else {
                    return UICollectionViewCell()
                }
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomTypeListCollectionViewCell.identifier, for: indexPath) as? BottomTypeListCollectionViewCell else {
                    return UICollectionViewCell()
                }
                return cell
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = sections[indexPath.section]
        if collectionViewtype {
            switch model {
            case .Artist :
                
                let width = collectionView.width
                let height = width * 6 / 31
                return CGSize(width: width, height: height)
            case .Playlist:
                let width = collectionView.width
                let height = width * 6 / 31
                return CGSize(width: width, height: height)
            case .Bottom:
                let width = collectionView.width
                let height = width * 12 / 31
                return CGSize(width: width, height: height)
                
            }
        } else {
            switch model {
            case .Bottom :
                let width = collectionView.width
                let height = width * 54 / (41*3)
                return CGSize(width: width, height: height)
            default :
                let width = (collectionView.width - 20) / 3
                let height = width * 54/41
                return CGSize(width: width, height: height)
            }
        }
       
        
    }
}
extension LibraryViewController : PreviewLibraryViewControllerDelegate {
    func handleOpenCreatePlaylist() {
        
        for child in children {
            if let previewVC = child as? PreviewLibraryViewController {
                UIView.animate(withDuration: 0.3, animations: {
                    previewVC.view.frame = CGRect(x: 0, y: self.view.height, width: self.view.frame.width , height: self.view.frame.height)
                }) { _ in
                    previewVC.willMove(toParent: nil)
                    previewVC.view.removeFromSuperview()
                    previewVC.removeFromParent()
                }
            }
        }
        let vc = CreatePlaylistViewController()
        present(vc, animated: true)
    }
    
    
}
