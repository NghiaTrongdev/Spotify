//
//  SettingViewController.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/5/24.
//

import UIKit

class SettingViewController: UIViewController {
    
    private var sections = [Section]()
    
    private var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Setting"
        view.backgroundColor = .systemBackground
        configuareModel()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configuareModel(){
        sections.append(Section(title: "Profile", options: [Option(title: "View Profile", handle: {[weak self] in
            DispatchQueue.main.async {
                self?.viewProfile()
            }
            
        })]))
        sections.append(Section(title: "Account", options:[ Option(title: "Sign Out", handle: {[weak self] in
            DispatchQueue.main.async  {
                self?.didTapSignOut()
            }
           
        })]))
    }
    private func didTapSignOut(){
        
    }
    private func viewProfile(){
        let vc = ProfileViewController()
        vc.title = "Profile"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    

}
extension SettingViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        
        cell.textLabel?.text = model.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = sections[indexPath.section].options[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        model.handle()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
    
    
}
