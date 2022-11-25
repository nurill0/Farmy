//
//  WelcomeVC.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 24/10/22.
//

import Foundation
import UIKit
import Lottie


class WelcomeVC: BaseVC{
    
    let model = WelcomeData()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        collectionV.register(WelcomeCell.self, forCellWithReuseIdentifier: WelcomeCell.identifer)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.isPagingEnabled = true
        collectionV.showsHorizontalScrollIndicator = false
        
        return collectionV
    }()
    
    lazy var pageControl: BorderedPageControl = {
        let control = BorderedPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfPages = 3
        control.transform = CGAffineTransform(scaleX: 2, y: 2); // Looks better!
        control.currentPageIndicatorTintColor =  .baseColor()
        control.backgroundStyle = .minimal
        
        return control
    }()
    
    lazy var enterBtn: AppButton = {
        let btn = AppButton(title: "Ro'yxatdan o'tish".uppercased(), fontSize: 18, bgcColor: .baseColor(), titleColor: .white, alignment: .center, tag: 0)
        btn.layer.cornerRadius = 15
        btn.isHidden = true
        btn.addTarget(self, action: #selector(goSendCodePage), for: .touchUpInside)
        
        return btn
    }()
    
}



//actions
extension WelcomeVC{
    
    @objc func goSendCodePage(){
        let vc =  SendCodeVC()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



//lifecycle
extension WelcomeVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        UserDefaultsManager.shared.setImgNum(imgNum: 0)
    }
    
}



//configure UI
extension WelcomeVC{
    
    
    fileprivate func configureUI(){
        enterBtnConst()
        pageControlConst()
        collectionViewConst()
    }
    
    
    fileprivate func enterBtnConst(){
        baseContainerV.addSubview(enterBtn)
        
        enterBtn.right(baseContainerV.rightAnchor, -20)
        enterBtn.left(baseContainerV.leftAnchor, 20)
        enterBtn.height(50)
        enterBtn.bottom(baseContainerV.bottomAnchor, -10)
    }
    
    
    fileprivate func pageControlConst(){
        baseContainerV.addSubview(pageControl)
        
        pageControl.right(baseContainerV.rightAnchor, -20)
        pageControl.left(baseContainerV.leftAnchor, 20)
        pageControl.bottom(enterBtn.topAnchor, -10)
        pageControl.height(30)
    }
    
    
    fileprivate func collectionViewConst(){
        baseContainerV.addSubview(collectionView)
        
        collectionView.top(baseContainerV.topAnchor, 20)
        collectionView.right(baseContainerV.rightAnchor)
        collectionView.left(baseContainerV.leftAnchor)
        collectionView.bottom(pageControl.topAnchor, -10)
    }
    
    
}



//collectionView delegate + datasource
extension WelcomeVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.getSize()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WelcomeCell.identifer, for: indexPath) as! WelcomeCell
        
        cell.updateUI(title: model.getItem(index: indexPath.item).title, description: model.getItem(index: indexPath.item).description, lottie: model.getItem(index: indexPath.item).lottieName)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.item
        if indexPath.item == 2{
            enterBtn.isHidden = false
        }else{
            enterBtn.isHidden = true
        }
    }
    
}

