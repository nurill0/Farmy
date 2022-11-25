//
//  ProductsVC.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 13/11/22.
//

import Foundation
import UIKit

class ProductsVC: BaseVC{
    
    var productModel: [ProductsModel] = []
    let userD = UserDefaultsManager.shared
    let dbManager = DatabaseManager.shared
    var productType = ""
    
    lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.showsVerticalScrollIndicator = false
        collectionV.register(ProductsCell.self, forCellWithReuseIdentifier: ProductsCell.id)
        collectionV.contentInsetAdjustmentBehavior = .always

        return collectionV
    }()
}



//lifecycle
extension ProductsVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        dbManager.getProduct(productType: "Mevalar")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}



//collectionView delegate + datasource
extension ProductsVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userD.getDataSize()
  
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCell.id, for: indexPath) as! ProductsCell
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.view.frame.height >= 812{
            return CGSize(width: (collectionView.frame.width/2), height: collectionView.frame.height*0.39)
        }else{
            return CGSize(width: (collectionView.frame.width/2), height: view.frame.height*0.39)
        }
 
    }
    
    
    
}



//actions and functions
extension ProductsVC{
    
}



//ui constraints
extension ProductsVC{
    
    fileprivate func configureUI(){
        collectionViewConst()
    }
    
    
    fileprivate func collectionViewConst(){
        view.addSubview(collectionView)
        
        collectionView.top(view.topAnchor)
        collectionView.right(view.rightAnchor)
        collectionView.left(view.leftAnchor)
        collectionView.bottom(view.bottomAnchor)
    }
    
}



