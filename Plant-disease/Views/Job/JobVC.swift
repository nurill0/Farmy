//
//  JobVC.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 27/10/22.
//

import Foundation
import UIKit
import Lottie

class JobVC: BaseVC{
    
    var animationView: AnimationView?
    
    lazy var searchIcon : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "search")
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
    
}



//lifecycle
extension JobVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.rightBarButtonItems = nil
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.titleView = nil
        self.animationView?.play()
        self.baseNavbarTitleLbl.text = "Job"
    }
    
}



//UI
extension JobVC{
    
    fileprivate func configureUI(){
        configureAnimationView()
        searchBarConst()
        searchIconConst()
    }
    
    fileprivate func searchBarConst(){
        view.addSubview(searchBar)
        
        view.bringSubviewToFront(searchBar)
        if self.view.frame.height >= 812{
            searchBar.top(self.view.topAnchor, 60)
        }else{
            searchBar.top(self.view.topAnchor, 30)
        }
        
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
    
    
    func configureAnimationView(){
        animationView = .init(name: "empty")
        animationView?.animationSpeed = 1
        view.addSubview(animationView!)
        animationView?.play()
        animationView?.loopMode = .loop
        animationView?.frame = view.frame
    }
    
}
