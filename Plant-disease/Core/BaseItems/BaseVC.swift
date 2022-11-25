//
//  BaseVC.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 17/10/22.
//
import Foundation
import UIKit

var navPadding = -100
struct DrawingConstants {
    let btnsPadding: CGFloat = 20
    let cardsSidePadding: CGFloat = 20
    let commonItemsHeight: CGFloat = 107
}

class BaseVC: UIViewController {
    
    let drawingConst = DrawingConstants()
    
    lazy var baseContainerV: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    let baseNavbarTitleLbl = UILabel()
    let baseUserNameTitleLbl = UILabel()
    
    lazy var customNavTitleV: UIView = {
        let titleV = UIView()
        titleV.addSubview(baseNavbarTitleLbl)
        titleV.addSubview(baseUserNameTitleLbl)
        
        baseNavbarTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        baseNavbarTitleLbl.textAlignment = .left
        baseNavbarTitleLbl.textColor = .gray
        baseNavbarTitleLbl.font = AppFont.font(type: .medium, size: 16)
        baseNavbarTitleLbl.isHidden = false
    
        
        let titleLeft = baseNavbarTitleLbl.leftAnchor.constraint(equalTo: titleV.leftAnchor)
        let titleBottom = baseNavbarTitleLbl.bottomAnchor.constraint(equalTo: titleV.bottomAnchor, constant: -3)
        let titleTop = baseNavbarTitleLbl.topAnchor.constraint(equalTo: titleV.topAnchor, constant: 3)
        let titleRight = baseNavbarTitleLbl.rightAnchor.constraint(equalTo: titleV.rightAnchor)

        titleV.addConstraints([titleTop, titleLeft, titleRight, titleBottom])
        
        return titleV
    }()
    
    
    var _backBarBtn: UIBarButtonItem!
    var backBarBtn: UIBarButtonItem {
        if _backBarBtn == nil {
            _backBarBtn = UIBarButtonItem(image: UIImage(named: "backIcon")?.withRenderingMode(.alwaysOriginal).withTintColor(.baseColor()), style: .plain, target: self, action: #selector(backBarBtnAction))
        }
        return _backBarBtn
    }
    
    var _cartBarBtn: UIBarButtonItem!
    var cartBarBtn: UIBarButtonItem{
        get{
            if _cartBarBtn == nil{
                let img = UIImage(named: "cart")?.withTintColor(UIColor.titleColors(), renderingMode: .alwaysOriginal)
                _cartBarBtn = UIBarButtonItem.init(image: img, style: .plain, target: self, action: #selector(self.cartBarBtnAction))
            }
            return _cartBarBtn
        }
    }
    
    var _favouriteBarBtn: UIBarButtonItem!
    var favouriteBarBtn: UIBarButtonItem{
        get{
            if _favouriteBarBtn == nil{
                let img = UIImage(named: "like")?.withTintColor(UIColor.titleColors(), renderingMode: .alwaysOriginal)
                _favouriteBarBtn = UIBarButtonItem.init(image: img, style: .plain, target: self, action: #selector(self.favouritetBarBtnAction))
            }
            return _favouriteBarBtn
        }
    }
    
    
    @objc func backBarBtnAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cartBarBtnAction(){
        //cart btn action
    }
    
    @objc func favouritetBarBtnAction(){
        //like btn action
    }
    
    var _changeFontBarBtn: UIBarButtonItem!
    var changeFontBarBtn: UIBarButtonItem {
        if _changeFontBarBtn == nil {
            _changeFontBarBtn = UIBarButtonItem(image: UIImage(named: "changeFontIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(changeFontBarBtnAction))
        }
        return _changeFontBarBtn
    }
    
    
    @objc func changeFontBarBtnAction(){
        //slider button action
    }
    
    
    var _threeDotsBarBtn: UIBarButtonItem!
    var threeDotsBarBtn: UIBarButtonItem {
        if _threeDotsBarBtn == nil {
            _threeDotsBarBtn = UIBarButtonItem(image: UIImage(named: "threeDotsIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(threeDotsBarBtnAction))
        }
        return _threeDotsBarBtn
    }
    
    
    @objc func threeDotsBarBtnAction(){
        //menu button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        baseContainerV.backgroundColor = .systemBackground
        setUpConstraints()
    }
    
    
    func setUpConstraints(){
        parentContainerVConstraints()
    }
    
    
    fileprivate func parentContainerVConstraints(){
        self.view.addSubview(baseContainerV)
        
        baseContainerV.top(self.view.topAnchor, safeAreaTop)
        baseContainerV.bottom(self.view.bottomAnchor, -safeAreaBottom)
        baseContainerV.left(self.view.leftAnchor, 0)
        baseContainerV.right(self.view.rightAnchor, 0)
    }
    
}
