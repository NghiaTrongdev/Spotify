import UIKit

protocol RecommendationforCollectionViewCellDelegate: AnyObject {
    func recommendationCellDidLongPress(_ cell: RecommendationforCollectionViewCell, model: RecommendationCellModel)
    func recommendationCellDidTap ( model: RecommendationCellModel)
}

class RecommendationforCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecommendationforCollectionViewCell"

    @IBOutlet weak var backgroundforcollection: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var models: [RecommendationCellModel] = []
    weak var delegate: RecommendationforCollectionViewCellDelegate?
    
    func configureModel(data: [RecommendationCellModel], temp: Int) {
        self.models = data
        collectionView.reloadData()
    }
    
    private func setupUI() {
  
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        collectionView.collectionViewLayout = layout
        let collection1 = UINib(nibName: "RecommendCollectionViewCell", bundle: nil)
        collectionView.register(collection1, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    @objc private func didLongPressCell(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began,
              let cell = gesture.view as? RecommendCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        
        let model = models[indexPath.row]
        delegate?.recommendationCellDidLongPress(self, model: model)
    }
    @objc private func didTapCell(_ gesture: UITapGestureRecognizer) {
        
        guard let cell = gesture.view as? RecommendCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        
        let model = models[indexPath.row]
        delegate?.recommendationCellDidTap(model: model)
    }
}

extension RecommendationforCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as? RecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configuareModel(model: models[indexPath.row])
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressCell(_:)))
        cell.addGestureRecognizer(longPressGesture)
        
        let tapCell = UITapGestureRecognizer(target: self, action: #selector(didTapCell(_: )))
        cell.addGestureRecognizer(tapCell)
        return cell
    }
    
    
    
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = 10.0
        let width = (collectionView.width - 2 * spacing) / 2.3
        let height = width * 1.25
        return CGSize(width: width, height: height)
    }
}
