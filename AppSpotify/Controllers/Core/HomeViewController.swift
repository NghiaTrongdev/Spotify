//
//  HomeViewController.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/5/24.
//

import UIKit

enum TypeBrowseSection {
    case NewRealease(viewmodels : [NewReleaseCellViewModel])
    case NewFeature(viewmodels : [NewFeatureCellModel])
    case NewRecommendation(viewmodels : [RecommendationCellModel])
    case RecentlyPlayed(viewmodels : [RecentlyPlayedViewModels])
}

class HomeViewController: UIViewController {
    
    private var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30.0
        layout.minimumInteritemSpacing = 20.0
        let view = UICollectionView(frame: .zero,collectionViewLayout: layout)
        let collection1 = UINib(nibName: "RecentforcollectionCollectionViewCell", bundle: nil)
        let collection2 = UINib(nibName: "RecommendationforCollectionViewCell", bundle: nil)
        let collection3 = UINib(nibName: "NewRealeaseforCollectionViewCell", bundle: nil)
        let collection4 = UINib(nibName: "FeatureforCollectionViewCell", bundle: nil)
        
        
        view.register(collection1, forCellWithReuseIdentifier: RecentforcollectionCollectionViewCell.identifier)
        view.register(collection2, forCellWithReuseIdentifier: RecommendationforCollectionViewCell.identifier)
        view.register(collection3, forCellWithReuseIdentifier: NewRealeaseforCollectionViewCell.identifier)
        view.register(collection4, forCellWithReuseIdentifier: FeatureforCollectionViewCell.identifier)
        //        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.register(SeactionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SeactionHeaderReusableView.identifier)
        
        
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
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
        
        headerView = HeaderUIView()
        headerView?.translatesAutoresizingMaskIntoConstraints = false
        guard let headerView = headerView else { return }
        
        headerView.delegate = self
        headerView.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(spinner)
        view.addSubview(collectionView)
        
        // handle tap to dissmis previewcontroller
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsidePreview))
        view.addGestureRecognizer(tapGesture)
        
        
        //
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchData()
        //
    }
    
    // MARK: - Handle close Preview
    
    
    @objc private func handleTapOutsidePreview() {
        for child in children {
            if let previewVC = child as? PreviewProfileViewController {
                UIView.animate(withDuration: 0.3, animations: {
                    previewVC.view.frame = CGRect(x: -self.view.frame.width, y: 0, width: self.view.frame.width * 0.9, height: self.view.frame.height)
                }) { _ in
                    previewVC.willMove(toParent: nil)
                    previewVC.view.removeFromSuperview()
                    previewVC.removeFromParent()
                }
            }
        }
    }
    
    // MARK: - init data
    
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
        
        sections.append(.RecentlyPlayed(viewmodels: recently.compactMap({
            return RecentlyPlayedViewModels(name: $0.track.name, artworkURL: URL(string: $0.track.album.images.first?.url ?? "") , numberOfTracks: $0.track.track_number, artistName: $0.track.artists.first?.name ?? "_")
        })))
        
        sections.append(.NewRecommendation(viewmodels:recommend.compactMap({
            let artistNames = $0.artists.map { $0.name }.joined(separator: ", ")
            return RecommendationCellModel(id: $0.id, image: URL(string: $0.album.images.first?.url ?? ""), name: $0.name, artists: artistNames, numberoftrack: $0.track_number)
        }) ))
        sections.append(.NewRealease(viewmodels: newAlbum.compactMap({
            let artistNames = $0.artists.map { $0.name }.joined(separator: ", ")
            return NewReleaseCellViewModel(name: $0.name, artworkURL:URL(string: $0.images.first?.url ?? "") , numberOfTracks: $0.total_tracks, artistName: artistNames)
        })))
        
        sections.append(.NewFeature(viewmodels: playlist.compactMap {
            
            return NewFeatureCellModel(name: $0.name, id: $0.id, urlString: URL(string: $0.images?.first?.url ?? "" ), createName: $0.owner.display_name)
        }))
        
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
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50)])
        collectionView.frame = CGRect(x: 0, y: headerView.bottom + 10, width: view.width, height: view.height)
        
    }
    
    
}
// MARK: - HANDLE HeaderUiView


extension HomeViewController : HeaderUIViewDelgate {
    func profileButtonDidTapped() {
        
        let vc = PreviewProfileViewController()
        vc.modalPresentationStyle = .overCurrentContext
        
        // init view with location is in the left of home view
        vc.view.frame = CGRect(x: -view.frame.width, y: 0, width: view.frame.width * 0.9, height: view.frame.height)
        
        
        // add to handle close after
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        UIView.animate(withDuration: 0.3) {
            vc.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.9, height: self.view.frame.height)
        }
    }
    
    
    
    func allbuttonDidTapped() {
        //
        print("tapped")
    }
    
    func songbuttonDidTapped() {
        print("tapped")
    }
    
    func podcastsButtonDidTapped() {
        print("tapped")
    }
    
    
}

// MARK: - HANDLE COLLECITONVIEW
extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = sections[section]
        switch model {
        case.RecentlyPlayed(let viewmodels):
            return viewmodels.count / 2
        case.NewFeature(let viewmodels):
            return viewmodels.count
        case.NewRealease(_):
            return /*viewmodels.count / 2*/ 1
        case.NewRecommendation(_):
            return 1
            
        }
        
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = sections[indexPath.section]
        switch model {
        case.RecentlyPlayed(let viewmodels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentforcollectionCollectionViewCell.identifier, for: indexPath) as?RecentforcollectionCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configuareModel(models: viewmodels)
            
            return cell
            
        case.NewFeature(let viewmodels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:FeatureforCollectionViewCell.identifier, for: indexPath) as? FeatureforCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model = viewmodels[indexPath.row]
            cell.configuareModel(model: model)
            return cell
        case.NewRealease(let viewmodels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewRealeaseforCollectionViewCell.identifier, for: indexPath) as? NewRealeaseforCollectionViewCell else {
                return UICollectionViewCell()
            }
        
            cell.configuareModel(models: viewmodels)
            return cell
        case.NewRecommendation(let viewmodels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationforCollectionViewCell.identifier, for: indexPath) as?  RecommendationforCollectionViewCell else {
                return UICollectionViewCell()
                
            }
        
            cell.configureModel(data: viewmodels, temp: indexPath.row)
            cell.delegate = self
            return cell
            
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let type = sections[indexPath.section]
        switch type {
        case .RecentlyPlayed:
            
            let width = collectionView.width
            let height : CGFloat = width / 6.0
            return CGSize(width: width, height: height)
        case .NewRealease(viewmodels: _):
            let width = collectionView.frame.width
            let height : CGFloat = (width / 2) * 1.25
            return CGSize(width: width, height: height)
        case .NewFeature(viewmodels: _):
            let height = collectionView.height / 2
            let width = collectionView.width - 20
            return CGSize(width: width, height: height)
            
            //
        case .NewRecommendation(viewmodels: _):
            //
            let width = collectionView.frame.width
            let height : CGFloat = (width / 2) * 1.25
            return CGSize(width: width, height: height)
            
        }
        return CGSize(width: 1, height: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let model = sections[section]
        switch model {
        case .RecentlyPlayed:
            return 10.0 // Default spacing for Recently Played
        default:
            return 50.0 // Increased spacing for other sections
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let model = sections[section]
        switch model {
        case .RecentlyPlayed:
            return 10.0 // Default spacing for Recently Played
        default:
            return 50.0 // Increased spacing for other sections
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SeactionHeaderReusableView.identifier, for: indexPath) as! SeactionHeaderReusableView
        
        let title: String
        switch sections[indexPath.section] {
        case .RecentlyPlayed:
            title = "Mới phát gần đây"
        case .NewFeature:
            title = "Những album hàng đầu"
        case .NewRealease:
            title = "Nhứng tác phẩm mới ra lò"
        case .NewRecommendation:
            title = "Dành cho bạn"
        }
        
        headerView.configure(with: title)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let model = sections[section]
        switch model {
        case .RecentlyPlayed:
            return UIEdgeInsets(top: 40, left: 0, bottom: 20, right: 0)
        case .NewFeature :
            return UIEdgeInsets(top: 50, left: 0, bottom: 20, right: 0)
        default:
            return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        }
    }
}

// MARK: - HANDLE OPEN HOLDON CONTROLLER
extension HomeViewController: RecommendationforCollectionViewCellDelegate {
    func recommendationCellDidTap(model: RecommendationCellModel) {
        //
        let vc = PlaylistViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func recommendationCellDidLongPress(_ cell: RecommendationforCollectionViewCell, model: RecommendationCellModel) {
        openHodlOn()
    }
    func openHodlOn(){
        let holdOnVC = HoldOnViewController()
        
        //        holdOnVC.configuareView(url: url, mess: model.name)
        holdOnVC.modalPresentationStyle = .overFullScreen
        holdOnVC.modalTransitionStyle = .crossDissolve
        present(holdOnVC, animated: true, completion: nil)
    }
}

extension HomeViewController : HoldOnViewControllerDelegate {
    func handlePlusButtonClick() {
        //
    }
    
    func handleShareButtonClick() {
        //
    }
    
    func handleCloseButtonClick() {
        print("tapped")
        //        dismiss(animated: true, completion: nil)
    }
    
    
}
