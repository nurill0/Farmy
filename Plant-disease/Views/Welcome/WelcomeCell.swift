//
//  WelcomeCell.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 24/10/22.
//

import Foundation
import UIKit
import Lottie

var animationName = "welcome1"
var customIndex = 0

class WelcomeCell: UICollectionViewCell{
    
    var animationView: AnimationView?
    static let identifer = "Welcomecell"
    
    lazy var containerV: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "O`simligingizni kasalligini aniqlayolmayapsizmi?"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = AppFont.font(type: .italic, size: 22)
        label.textColor = .baseColor()
        
        return label
    }()
    
    lazy var descriptionLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bizga o'simlik rasmini yuklang,biz esa sizga undagi kasallikni aniqlashga yordam beramiz !"
        label.textAlignment = .center
        label.font = AppFont.font(type: .italic, size: 20)
        label.numberOfLines = 0
        label.textColor = .baseColor()
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        animationView = .init(name: animationName)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



//updater
extension WelcomeCell{
    
    func updateUI(title: String, description: String, lottie: String){
        self.titleLbl.text = title
        self.descriptionLbl.text = description
        animationName = lottie
    }
    
}



//configure and constraint UI
extension WelcomeCell{
    
    fileprivate func configureUI(){
        containerVConst()
        configureAnimationView()
        titleLblConst()
        descrLblConst()
    }
    
    
    fileprivate func containerVConst(){
        self.contentView.addSubview(containerV)
        
        containerV.top(self.contentView.topAnchor)
        containerV.left(self.contentView.leftAnchor)
        containerV.right(self.contentView.rightAnchor)
        containerV.bottom(self.contentView.bottomAnchor)
    }
    
    
    func configureAnimationView(){
        animationView?.animationSpeed = 1
        containerV.addSubview(animationView!)
        animationView?.play()
        animationView?.loopMode = .loop
        animationView?.frame = CGRect(x: self.frame.width / 2 - 125, y: 20, width: 250, height: 250)
    }
    
    
    fileprivate func titleLblConst(){
        self.containerV.addSubview(titleLbl)
        
        titleLbl.top(animationView!.bottomAnchor, 20)
        titleLbl.right(containerV.rightAnchor, -15)
        titleLbl.left(containerV.leftAnchor, 15)
    }
    
    
    fileprivate func descrLblConst(){
        self.containerV.addSubview(descriptionLbl)
        
        descriptionLbl.top(titleLbl.bottomAnchor, 30)
        descriptionLbl.right(titleLbl.rightAnchor)
        descriptionLbl.left(titleLbl.leftAnchor)
    }
    
}
