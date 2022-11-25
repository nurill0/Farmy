//
//  ProductsCell.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 13/11/22.
//

import UIKit

class ProductsCell: UICollectionViewCell {
    static let id = "productcell"
    
    lazy var containerV: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.baseColor().cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        
        return view
    }()
    
    
    lazy var productImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.masksToBounds = true
        img.image = UIImage(named: "apple")
        
        return img
    }()
    
    lazy var productTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Qovun tarvuz anor"
        lbl.textAlignment = .left
        lbl.textColor = .titleColors()
        lbl.font = AppFont.font(type: .bold, size: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0

        return lbl
    }()
    
    lazy var pricePerLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "1 dona - 900000 so'm"
        lbl.textAlignment = .left
        lbl.textColor = .titleColors()
        lbl.font = AppFont.font(type: .medium, size: 18)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    lazy var likeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "like")?.withTintColor(.baseColor(), renderingMode: .alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




extension ProductsCell{
    
    fileprivate func configureUI(){
        containerVConst()
        productImgConst()
        likeBtnConst()
        pricePerLblConst()
        productTitleLblConst()
    }
    
    
    fileprivate func containerVConst(){
        self.contentView.addSubview(containerV)
        
        containerV.top(contentView.topAnchor, 10)
        containerV.bottom(contentView.bottomAnchor, -10)
        containerV.left(contentView.leftAnchor, 10)
        containerV.right(contentView.rightAnchor, -10)
    }
    
    
    fileprivate func productImgConst(){
        containerV.addSubview(productImg)
        
        productImg.top(containerV.topAnchor)
        productImg.left(containerV.leftAnchor)
        productImg.right(containerV.rightAnchor)
        productImg.bottom(containerV.centerYAnchor)
    }
    
    
    fileprivate func productTitleLblConst(){
        containerV.addSubview(productTitle)
        
        productTitle.top(productImg.bottomAnchor, 2)
        productTitle.left(containerV.leftAnchor, 10)
        productTitle.right(containerV.rightAnchor, -10)
    }
    
    
    fileprivate func pricePerLblConst(){
        containerV.addSubview(pricePerLbl)
        
        pricePerLbl.left(containerV.leftAnchor, 10)
        pricePerLbl.right(likeBtn.leftAnchor, -5)
        pricePerLbl.bottom(containerV.bottomAnchor,-10)
    }
    
    fileprivate func likeBtnConst(){
        containerV.addSubview(likeBtn)
        
        likeBtn.bottom(containerV.bottomAnchor, -10)
        likeBtn.right(containerV.rightAnchor, -10)
        likeBtn.height(24)
        likeBtn.height(24)
    }
}
