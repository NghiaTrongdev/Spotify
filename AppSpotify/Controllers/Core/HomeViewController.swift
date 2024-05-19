//
//  HomeViewController.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/5/24.
//

import UIKit

enum TypeBrowseSection {
    case NewRealease(viewmodels : [NewReleaseCellViewModel])
    case NewFeature(viewmodels : [NewReleaseCellViewModel])
    case NewRecommendation(viewmodels : [NewReleaseCellViewModel])
    case RecentlyPlayed(viewmodels : [RecentlyPlayedViewModels])
}

class HomeViewController: UIViewController {
  
    private var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20.0
        layout.minimumInteritemSpacing = 10.0
        let view = UICollectionView(frame: .zero,collectionViewLayout: layout)
        let collection1 = UINib(nibName: "RecentforcollectionCollectionViewCell", bundle: nil)
        view.register(collection1, forCellWithReuseIdentifier: RecentforcollectionCollectionViewCell.identifier)
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    
    private var headerView :HeaderUIView?
    private var spinner : UIActivityIndicatorView = {
        let temp = UIActivityIndicatorView()
        temp.tintColor = .label
        temp.hidesWhenStopped = true
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .systemBackground
        
        headerView = HeaderUIView(frame: CGRect(x: 0, y:96, width: view.width, height: 50))
        guard let headerView = headerView else {
            return
        }
        headerView.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(spinner)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchData()
//
    }

 
    private var sections  = [TypeBrowseSection]()
    
    
    private func fetchData(){
        // new Release
        
        
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        group.enter()
        
        var releases : NewReleaseResponse?
        var features : FeaturedPlaylistResponse?
        var recommendations : Recommendation?
        var recentlys : RecentlyPlayedModel?
        ApiCallerManager.shared.getRecentlytPlayed { result in
            defer {
                group.leave()
            }
            switch result{
            case.success(let model):
                recentlys = model
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        ApiCallerManager.shared.getNewRelease { result in
            defer {
                group.leave()
            }
            switch result{
            case.success(let model):
                releases = model
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        ApiCallerManager.shared.getFeaturedPlaylist { result in
            defer {
                group.leave()
            }
           
            switch result{
            case.success(let model):
                features = model
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
        ApiCallerManager.shared.getRecommendGenres { result in
            switch result {
            case.success(let model):
                var seeds = Set<String>()
                let genres = model.genres
                while seeds.count < 5 {
                    if let randum = genres.randomElement() {
                        seeds.insert(randum)
                    }
                }
                ApiCallerManager.shared.getRecommendations(genres: seeds) { result in
                    defer {
                        group.leave()
                    }
                   
                    switch result{
                    case.success(let model):
                        recommendations = model
                    case.failure(let error):
                        print(error.localizedDescription)
                    }
                }
                break
            case.failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
        
        group.notify(queue: .main){
            guard let newAlbums = releases?.albums.items,
                  let playlists = features?.playlists.items ,
                  let tracks = recommendations?.tracks,
                  let recents = recentlys?.items
            else {
                return
            }
            self.configuareModel(newAlbum: newAlbums, playlist: playlists, recommend: tracks,recently: recents)
        }
        
    }
    private func configuareModel(newAlbum : [Album] , playlist : [PlayList], recommend : [AudioTrack],recently : [playHistory]){
//        sections.append(.NewRealease(viewmodels:newAlbum.compactMap({
//            return NewReleaseCellViewModel(name: $0.name, artworkURL: URL(string: $0.images.first?.url ?? "") , numberOfTracks: $0.total_tracks, artistName: $0.artists.first?.name ?? "_")
//        }) ))
        sections.append(.NewRealease(viewmodels: []))
        sections.append(.RecentlyPlayed(viewmodels: recently.compactMap({
            return RecentlyPlayedViewModels(name: $0.track.name, artworkURL: URL(string: $0.track.album.images.first?.url ?? "") , numberOfTracks: $0.track.track_number, artistName: $0.track.artists.first?.name ?? "_")
        })))
        sections.append(.NewFeature(viewmodels: []))
        sections.append(.NewRecommendation(viewmodels:[] ))
        collectionView.reloadData()
    }
  
    @objc private func didtapSettingButton(){
        let vc = SettingViewController()
        vc.title = "Setting"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let headerView = headerView else {
            return
        }
        collectionView.frame = CGRect(x: 0, y: headerView.bottom + 10, width: view.width, height: view.height)
        
    }
    

}
extension HomeViewController : HeaderUIViewDelgate {
    func profileButtonDidTapped() {
        //
    }
    
    func allbuttonDidTapped() {
        //
    }
    
    func songbuttonDidTapped() {
        //
    }
    
    func podcastsButtonDidTapped() {
        //
    }
    
    
}
extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = sections[section]
        switch model {
        case.NewFeature(let viewmodels):
            return viewmodels.count
        case.NewRealease(let viewmodels):
            return /*viewmodels.count / 2*/ 1
        case.NewRecommendation(let viewmodels):
            return viewmodels.count
        case.RecentlyPlayed(let viewmodels):
            return viewmodels.count
        }
        
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = sections[indexPath.section]
        switch model {
        case.NewFeature(let viewmodels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath)
            cell.backgroundColor = .blue
            return cell
        case.NewRealease(let viewmodels):
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as?  RecommendCollectionViewCell else {
//                return UICollectionViewCell()
//            }
//            let model = viewmodels[indexPath.row]
//            cell.configuareModel(model: model)
//            return cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .green
            return cell
        case.NewRecommendation(let viewmodels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    
            return cell
        case.RecentlyPlayed(let viewmodels):
            let model = viewmodels[indexPath.row]
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentforcollectionCollectionViewCell.identifier, for: indexPath) as?RecentforcollectionCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configuareModel(model: viewmodels)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let type = sections[indexPath.section]
        switch type {
        case .RecentlyPlayed:
            
            let width = collectionView.width
            let height : CGFloat = 400
            return CGSize(width: width, height: height)
        case .NewRealease(viewmodels: let viewmodels): break
//            let spacing: CGFloat = 10.0
//         
//            let width = collectionView.width / 2.5
//            let height = width * ( 4 / 3)
//            return CGSize(width: width, height: height)
            //
        case .NewFeature(viewmodels: let viewmodels): break
            //
        case .NewRecommendation(viewmodels: let viewmodels): break
            //
        }
           return CGSize(width: 1, height: 1)
       }

//       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//           return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
//       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 10.0
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 10.0
       }
       
    
    
}
