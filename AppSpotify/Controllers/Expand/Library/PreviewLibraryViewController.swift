import UIKit
protocol PreviewLibraryViewControllerDelegate : AnyObject{
    func handleOpenCreatePlaylist()
}
class PreviewLibraryViewController: UIViewController {
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var viewList: UIView!
    @IBOutlet weak var viewGeneral: UIView!
    weak var delegate : PreviewLibraryViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        listener()
    }
    
    private func setupUI() {
        
        view.backgroundColor = UIColor(white: 0, alpha: 0.8)
        // Thêm border top cho bottomView
        bottomView.layer.cornerRadius = 10.0
        bottomView.layer.masksToBounds = true
        bottomView.alpha = 1.0
        viewList.alpha = 1.0
        viewGeneral.alpha = 1.0
    }
    
    private func listener(){
        let panGetuare = UIPanGestureRecognizer(target: self, action: #selector(closeView(_:)))
        bottomView.addGestureRecognizer(panGetuare)
        
        let clickPanGetuare = UITapGestureRecognizer(target: self, action: #selector(clickCreate))
        viewList.addGestureRecognizer(clickPanGetuare)
    }
    @objc private func closeView(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: bottomView)
       
        
        if gesture.state == .changed {
            // Chỉ cho phép kéo xuống
            if translation.y > 0 {
                bottomView.frame.origin.y = self.view.frame.height * 0.5 + translation.y
            }
        } else if gesture.state == .ended {
            if translation.y > bottomView.frame.height * 0.3 {
                // Nếu kéo xuống đủ xa hoặc kéo nhanh thì đóng view
                
                UIView.animate(withDuration: 0.3, delay: 0,options: .curveEaseOut, animations: {
                    self.bottomView.frame.origin.y = self.bottomView.height
                    self.view.backgroundColor = .clear
                    self.view.alpha = 1
                    self.view.frame.origin.y = self.view.frame.height
                }) { _ in
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                // Nếu không thì trở về vị trí cũ
                UIView.animate(withDuration: 0.3) {
                    self.bottomView.frame.origin.y = self.view.frame.height * 0.5
                }
            }
        }
    }
    @objc func clickCreate(){
        self.delegate?.handleOpenCreatePlaylist()
    }
  
}
