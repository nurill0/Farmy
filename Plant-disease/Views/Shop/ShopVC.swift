//
//  ShopVC.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 27/10/22.
//

import Foundation

import UIKit

class ShopVC: BaseVC{
    
    let managerUD = UserDefaultsManager.shared
    let dbManager = DatabaseManager.shared
    
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
    
    lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        btn.layer.cornerRadius = 25
        btn.backgroundColor = .baseColor()
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOpacity = 0.5
        btn.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
        
        return btn
    }()
    
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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.showsVerticalScrollIndicator = false
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.register(ShopCell.self, forCellWithReuseIdentifier: ShopCell.id)
        return collectionV
    }()
    
    
    override func cartBarBtnAction() {
        print("cart btn tapped")
    }
    
    
    override func favouritetBarBtnAction() {
        print("favourite btn tapped")
    }
    
    
    @objc func addBtnTapped(){
        let vc = AddProductVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



extension ShopVC{
    
}


//lifecycle
extension ShopVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extensionForLabel()
        configureUI()
        extensionForLabel()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.rightBarButtonItems = [ cartBarBtn,favouriteBarBtn]
        self.navigationItem.leftBarButtonItem = self.backBarBtn
        self.extensionForLabel()
    }
    
}



//collectionView delegate + datasource
extension ShopVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCell.id, for: indexPath) as! ShopCell
        switch indexPath.item {
        case 0:
            cell.titleLbl.text = "Mevalar"
            cell.productImgV.image = UIImage(named: "apple")
        case 1:
            cell.titleLbl.text = "Sabzavotlar"
            cell.productImgV.image = UIImage(named: "vegetable")
            
        case 2:
            cell.titleLbl.text = "Poliz-ekinlari"
            cell.productImgV.image = UIImage(named: "watermelon")
            
        case 3:
            cell.titleLbl.text = "Sut mahsulotlari"
            cell.productImgV.image = UIImage(named: "milk")
        default:
            cell.titleLbl.text = "Mahsulotlar"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height*3/5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductsVC()
        switch indexPath.item {
        case 0: vc.dbManager.getProductsSize(productType: "Mevalar")
        case 1: vc.dbManager.getProductsSize(productType: "Sabzavotlar")
        case 2: vc.dbManager.getProductsSize(productType: "Poliz-ekinlari")
        case 3: vc.dbManager.getProductsSize(productType: "Sut mahsulotlari")
        default:  vc.dbManager.getProductsSize(productType: "Sut mahsulotlari")
        }
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}



//actions
extension ShopVC{
    
    fileprivate func configureUI(){
        searchBarConst()
        searchIconConst()
        userNameLblConst()
        collectionViewConst()
        addBtnConst()
        
    }
    
    fileprivate func searchBarConst(){
        view.addSubview(searchBar)
        
        searchBar.top(self.view.safeAreaLayoutGuide.topAnchor, 20)
        searchBar.right(self.view.rightAnchor, -15)
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
    
    
    fileprivate func addBtnConst(){
        view.addSubview(addBtn)
        view.bringSubviewToFront(addBtn)
        addBtn.bottom(view.bottomAnchor, -20)
        addBtn.right(view.rightAnchor, -20)
        addBtn.height(50)
        addBtn.width(50)
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
    
    
    fileprivate func collectionViewConst(){
        view.addSubview(collectionView)
        
        collectionView.top(searchBar.bottomAnchor, 10)
        collectionView.left(view.leftAnchor)
        collectionView.right(view.rightAnchor)
        collectionView.bottom(view.bottomAnchor)
    }
    
}


extension ShopVC{
    
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
