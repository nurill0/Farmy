//
//  GardenViewController.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 11/11/22.
//

import Foundation
import UIKit


class GardenViewController: BaseVC {
    
    lazy var searchIcon : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "search")?.withTintColor(UIColor.titleColors())
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.placeholder = "Qidiring..."
        sb.searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 0))
        sb.searchTextField.leftViewMode = .always
        sb.layer.cornerRadius = 10
        sb.searchBarStyle = .minimal
        sb.searchTextField.font = AppFont.font(type: .medium, size: 18)
        
        return sb
    }()
    
    var leafImg = "leaf"
    
    lazy var leafImgV: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: leafImg)
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    lazy var galleryBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Gallery", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        btn.backgroundColor = .baseColor()
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var detectBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Detect", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        btn.backgroundColor = .baseColor()
        btn.layer.cornerRadius = 15
        
        return btn
    }()

    lazy var camereBtn: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Camera", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        btn.backgroundColor = .baseColor()
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(openCamera), for: .touchUpInside)

        
        return btn
    }()
    
    lazy var threedotBtn: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "menu")?.withTintColor(UIColor.titleColors()), for: .normal)
//        btn.addTarget(self, action: #selector(openCamera), for: .touchUpInside)

        
        return btn
    }()
    
    lazy var stackView: UIStackView = {
        let stackV = UIStackView()
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.spacing = 20
        stackV.axis = .horizontal
        stackV.distribution = .fillEqually
        
        return stackV
    }()
    
    
    @objc func openGallery(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    
    @objc func openCamera(){
        let vc = CameraVC()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



//photo edit
extension GardenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            leafImgV.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true )
    }
}



//Lifecycle
extension GardenViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.view.backgroundColor = .white
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.rightBarButtonItems = nil
        self.navigationItem.titleView = customNavTitleV
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        self.navigationItem.leftBarButtonItem = self.backBarBtn
        self.baseNavbarTitleLbl.text = "Plant-disease"
    }
    
}



//UI
extension GardenViewController{
    
    
    fileprivate func configureUI(){
        stackView.addArrangedSubview(galleryBtn)
        stackView.addArrangedSubview(detectBtn)
        stackView.addArrangedSubview(camereBtn)
        stackViewConst()
        leafImgVConst()
        searchBarConst()
        searchIconConst()
        menuBtnConst()
    }
    
    
    fileprivate func leafImgVConst(){
        baseContainerV.addSubview(leafImgV)
        
        leafImgV.top(baseContainerV.topAnchor, 3*drawingConst.btnsPadding)
        leafImgV.right(baseContainerV.rightAnchor, -drawingConst.btnsPadding)
        leafImgV.left(baseContainerV.leftAnchor, drawingConst.btnsPadding)
        leafImgV.bottom(stackView.topAnchor, -30)
    }
    
    
    fileprivate func stackViewConst(){
        baseContainerV.addSubview(stackView)
        
        stackView.centerY(baseContainerV.centerYAnchor, 20)
        stackView.right(baseContainerV.rightAnchor, -10)
        stackView.left(baseContainerV.leftAnchor, 10)
        stackView.height(60)
    }
    
    
    fileprivate func searchBarConst(){
        view.addSubview(searchBar)
        
        view.bringSubviewToFront(searchBar)
        if self.view.frame.height >= 812{
            searchBar.top(self.view.topAnchor, 60)
        }else{
            searchBar.top(self.view.topAnchor, 30)
        }
      
        searchBar.right(self.view.rightAnchor, -55)
        searchBar.left(self.view.leftAnchor, 15)
        searchBar.height(50)
    }
    
    
    fileprivate func searchIconConst(){
        searchBar.addSubview(searchIcon)
        
        searchIcon.centerY(searchBar.centerYAnchor)
        searchIcon.left(searchBar.searchTextField.leftAnchor, 10)
        searchIcon.width(20)
        searchIcon.height(20)
    }
    
    
    fileprivate func menuBtnConst(){
        view.addSubview(threedotBtn)
        
        threedotBtn.left(searchBar.rightAnchor)
        threedotBtn.right(view.rightAnchor, -10)
        threedotBtn.centerY(searchBar.centerYAnchor)
        threedotBtn.height(40)
    }
    
}





