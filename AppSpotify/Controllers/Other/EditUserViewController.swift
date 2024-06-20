//
//  EditUserViewController.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 6/6/24.
//

import UIKit

class EditUserViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var changeButton: UIButton!
    
    @IBOutlet weak var avata: UIImageView!
    
    var isEdited : Bool = false
    
    private func setupUI(){
        avata.layer.cornerRadius = avata.height/2.0
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(didtapSaveButton))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Huỷ", style: .plain, target: self, action: #selector(didtapCancelButton))
        changeButton.addTarget(self, action: #selector(didtapChangeButton), for: .touchUpInside)
        configuareModel()
    }
    
    @IBAction func NameTextChanged(_ sender: Any) {
        isEdited = true
        navigationItem.rightBarButtonItem?.isEnabled = true
        let text = txtName.text
        
        
    }
    private func configuareModel(){
        ApiCallerManager.shared.getCurrentUser { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.txtName.text = model.display_name
                    self.avata.sd_setImage(with:URL(string: model.images.first?.url ?? "") )
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chỉnh sửa hồ sơ"
        setupUI()
        
        
    }
    @objc func didtapChangeButton(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true)
    }
    @objc func didtapSaveButton(){
        dismiss(animated: true, completion: nil)
    }
    @objc func didtapCancelButton(){
        if isEdited {
            let alert = UIAlertController(title: "Huỷ thay đổi?", message: "Nếu quay lại ngay bây giờ, thì bạn sẽ mất các thay đổi của mình.", preferredStyle: .alert)
                   
                   // Custom "Tiếp tục chỉnh sửa" button
                   let continueAction = UIAlertAction(title: "Tiếp tục chỉnh sửa", style: .default, handler: { _ in
                       // Code để tiếp tục chỉnh sửa, không làm gì cả để đóng alert
                   })
                   continueAction.setValue(UIColor.green, forKey: "titleTextColor") // Custom màu chữ thành màu xanh
                   
                   // Custom "Huỷ" button
                   let cancelAction = UIAlertAction(title: "Huỷ", style: .destructive, handler: { _ in
                       self.dismiss(animated: true, completion: nil)
                   })
                   
                   alert.addAction(continueAction)
                   alert.addAction(cancelAction)
                   
                   present(alert, animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
       
    }
    
}
extension EditUserViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            avata.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
