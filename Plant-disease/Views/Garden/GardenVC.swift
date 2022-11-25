//
//  GardenVC.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 17/10/22.
//

import Foundation
import UIKit
import Lottie


class GardenVC: BaseVC {
    
    let managerUD = UserDefaultsManager.shared
    var animationView: AnimationView?

    lazy var userNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Xayrli kun\n\(managerUD.getUsername())"
        lbl.numberOfLines = 2
        lbl.textAlignment = .left
        lbl.textColor = UIColor.titleColors()
        lbl.font = AppFont.font(type: .bold, size: 18)
        
        return lbl
    }()
   
    lazy var searchIcon : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "search")?.withTintColor(UIColor.titleColors(), renderingMode: .automatic)
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
        sb.searchTextField.textColor = UIColor.titleColors()
        sb.searchTextField.font = AppFont.font(type: .medium, size: 18)
        
        return sb
    }()
    
    lazy var threedotBtn: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "menu")?.withTintColor(UIColor.titleColors()), for: .normal)
        
        return btn
    }()
    
    lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "camera")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        btn.layer.cornerRadius = 25
        btn.backgroundColor = .baseColor()
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOpacity = 0.5
        btn.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        
        return btn
    }()
    
    
    @objc func openCamera(){
        let vc = CameraVC()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}




//Lifecycle
extension GardenVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.rightBarButtonItems = [ cartBarBtn,favouriteBarBtn]
        self.navigationItem.leftBarButtonItem = self.backBarBtn
        self.animationView?.play()
        self.extensionForLabel()
    }

}



//UI
extension GardenVC{
    
    fileprivate func configureUI(){
        configureAnimationView()
        userNameLblConst()
        searchBarConst()
        menuBtnConst()
        searchIconConst()
        addBtnConst()
        
    }
    
    func configureAnimationView(){
        animationView = .init(name: "empty")
        animationView?.animationSpeed = 1
        view.addSubview(animationView!)
        animationView?.play()
        animationView?.loopMode = .loop
        animationView?.frame = view.frame
    }
    
    
    fileprivate func userNameLblConst(){
        view.addSubview(userNameLbl)
        view.bringSubviewToFront(addBtn)

        if self.view.frame.height >= 812{
            userNameLbl.top(view.topAnchor, 50)
        }else{
            userNameLbl.top(view.topAnchor, 25)
        }
        userNameLbl.left(view.leftAnchor, 10)
        userNameLbl.right(view.rightAnchor, -50)
    }
    
    
    fileprivate func searchBarConst(){
        view.addSubview(searchBar)
        
        searchBar.top(self.view.safeAreaLayoutGuide.topAnchor, 20)
        searchBar.right(self.view.rightAnchor, -60)
        searchBar.left(self.view.leftAnchor, 15)
        searchBar.height(50)
    }
    
    
    fileprivate func menuBtnConst(){
        view.addSubview(threedotBtn)

        threedotBtn.left(searchBar.rightAnchor)
        threedotBtn.right(view.rightAnchor, -10)
        threedotBtn.centerY(searchBar.centerYAnchor)
        threedotBtn.height(40)
    }
    
    
    fileprivate func searchIconConst(){
        searchBar.addSubview(searchIcon)
        
        searchIcon.centerY(searchBar.centerYAnchor)
        searchIcon.left(searchBar.searchTextField.leftAnchor, 10)
        searchIcon.width(20)
        searchIcon.height(20)
    }
    
    
    fileprivate func addBtnConst(){
        view.addSubview(addBtn)
        view.bringSubviewToFront(addBtn)
        addBtn.bottom(view.bottomAnchor, -20)
        addBtn.right(view.rightAnchor, -20)
        addBtn.height(50)
        addBtn.width(50)
    }
    
}



//extension for label
extension GardenVC{
    
    func extensionForLabel(){
        var textArray = [String]()
        var fontArray = [UIFont]()
        var colorArray = [UIColor]()
        
        textArray.append(" Xayrli kun\n")
        textArray.append(managerUD.getUsername())
        
        fontArray.append(AppFont.font(type: .medium, size: 15))
        fontArray.append(AppFont.font(type: .bold, size: 20))
        
        colorArray.append(.gray)
        colorArray.append(.titleColors())
        userNameLbl.attributedText = getAttributedString(arrayText: textArray, arrayColors: colorArray, arrayFonts: fontArray)
        userNameLbl.isUserInteractionEnabled = true
    }


    func getAttributedString(arrayText:[String]?, arrayColors:[UIColor]?, arrayFonts:[UIFont]?) -> NSMutableAttributedString {
        let finalAttributedString = NSMutableAttributedString()
        for i in 0 ..< (arrayText?.count)! {
            let attributes = [NSAttributedString.Key.foregroundColor: arrayColors?[i], NSAttributedString.Key.font: arrayFonts?[i]]
            let attributedStr = (NSAttributedString.init(string: arrayText?[i] ?? "", attributes: attributes as [NSAttributedString.Key : Any]))
            if i != 0 {
                finalAttributedString.append(NSAttributedString.init(string: " "))
            }
            finalAttributedString.append(attributedStr)
        }
        return finalAttributedString
    }

}
