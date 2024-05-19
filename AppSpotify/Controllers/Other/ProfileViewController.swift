//
//  ProfileViewController.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/5/24.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var models = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        view.backgroundColor = .systemBackground
        fetchAPI()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func fetchAPI(){
        ApiCallerManager.shared.getCurrentUser {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model) :
                    self?.updateUI(model: model)
                    break
                case .failure(let error ):
                    print(error.localizedDescription)
                    self?.failTogetUserProfile()
                    break
                }
            }
            
        }
    }
    private func updateUI(model : UserProfile){
        tableView.isHidden = false
        models.append("Full name \(model.display_name)")
        models.append("Email Address \(model.email)")
        models.append("User ID \(model.id)")
        models.append("Plan \(model.product)")
        createHeaderView(string: model.images.first?.url)
        tableView.reloadData()
    }
    private func failTogetUserProfile(){
        let errorLabel : UILabel = {
            let label = UILabel()
            label.text = "Fail to get user profile"
            label.sizeToFit()
            label.textColor = .secondaryLabel
            label.center = view.center
            return label
        }()
        view.addSubview(errorLabel)
    }
    private func createHeaderView(string : String?){
        guard let urlString = string , let url = URL(string: urlString) else {
            return
        }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))
        let imageSize : CGFloat = headerView.height / 2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize/2
        imageView.sd_setImage(with: url )
        tableView.tableHeaderView = headerView
    }

}

// MARK : -- EXTENSION
extension ProfileViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return models.count
//    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
        
    }
}
