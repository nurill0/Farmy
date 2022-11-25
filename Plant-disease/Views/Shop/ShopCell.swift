//
//  ShopCell.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 07/11/22.
//

import UIKit

class ShopCell: UICollectionViewCell {
    
    static let id = "shopcell"
    
    lazy var containerV: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    lazy var titleLbl: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Sabzavotlar"
        lbl.textColor = UIColor.titleColors()
        lbl.textAlignment = .left
        lbl.font = AppFont.font(type: .medium, size: 25)
        
        return lbl
    }()
    
    lazy var productImgV: UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "apple")
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 20
        img.clipsToBounds = true
        
        return img
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



extension ShopCell{
    
    fileprivate func configureUI(){
        containerVConst()
        titleLblConst()
        imgConst()
    }
    
    
    fileprivate func containerVConst(){
        self.contentView.addSubview(containerV)
        
        containerV.top(contentView.topAnchor, 20)
        containerV.bottom(contentView.bottomAnchor)
        containerV.left(contentView.leftAnchor, 20)
        containerV.right(contentView.rightAnchor, -20)
    }
    
    
    fileprivate func titleLblConst(){
        containerV.addSubview(titleLbl)
        
        titleLbl.top(containerV.topAnchor)
        titleLbl.left(containerV.leftAnchor)
        titleLbl.right(containerV.rightAnchor)
    }
    
    
    fileprivate func imgConst(){
        containerV.addSubview(productImgV)
        
        productImgV.backgroundColor = .green
        productImgV.top(titleLbl.bottomAnchor, 15)
        productImgV.right(containerV.rightAnchor)
        productImgV.left(containerV.leftAnchor)
        productImgV.bottom(containerV.bottomAnchor)
    }
    
}
