//
//  SignUpVC.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 27/10/22.
//

import Foundation
import UIKit
import Firebase
import Lottie

class SignUpVC: BaseVC{
    
    var animationView: AnimationView?
    let userDefaultsManager = UserDefaultsManager.shared
    let dbManager = DatabaseManager.shared
    var delegate: GetPhoneNumber?
    let database = Database.database().reference()
    
    
    lazy var welcomeLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Xush kelibsiz"
        lbl.textColor = .baseColor()
        lbl.textAlignment = .center
        lbl.font = AppFont.font(type: .bold, size: 25)
        
        return lbl
    }()
    
    lazy var userNameTF: AppTextFields = {
        let tf = AppTextFields(plaseHolder: "Username", textColor: .titleColors(), fontSize: 18, borderWidth: 2, borderColor: UIColor.baseColor(), cornerRadius: 18, keyBoardType: .default)
        tf.delegate = self
        
        return tf
    }()
    
    lazy var passwordTF: AppTextFields = {
        let tf = AppTextFields(plaseHolder: "Password", textColor: .titleColors(), fontSize: 18, borderWidth: 2, borderColor: UIColor.baseColor(), cornerRadius: 18, keyBoardType: .default)
        tf.isSecureTextEntry = true
        tf.delegate = self
        
        return tf
    }()
    
    lazy var enterBtn: AppButton = {
        let btn = AppButton(title: "Kirish", fontSize: 18, bgcColor: .baseColor(), titleColor: .white, alignment: .center, tag: 0)
        btn.layer.cornerRadius = 18
        btn.addTarget(self, action: #selector(goMainTabbar), for: .touchUpInside)
        
        return btn
    }()
    
}



//life cycle
extension SignUpVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        navigationItem.hidesBackButton = true
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.backBarButtonItem = nil
        self.navigationItem.titleView = customNavTitleV
        self.baseNavbarTitleLbl.text = ""
    }
    
}



//actions
extension SignUpVC{
    
    @objc func goMainTabbar(){
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        view.addSubview(indicator)
        view.bringSubviewToFront(indicator)
        indicator.startAnimating()
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        indicator.backgroundColor = .black.withAlphaComponent(0.6)
        indicator.bounds = view.bounds
        indicator.style = .large
        indicator.color = .black
        indicator.layer.borderWidth = 1
        guard let userName = userNameTF.text, !userName.isEmpty else { return }
        guard let password = passwordTF.text, !password.isEmpty else { return }
        
        DispatchQueue.main.async { [self] in
            let vc = MainVC()
            indicator.stopAnimating()
            vc.modalPresentationStyle = .fullScreen
            self.dbManager.addUserData(username: userName, phoneNum: self.userDefaultsManager.getPhoneNumber(), password: password)
            self.userDefaultsManager.setUserEnter(isUserEntered: true)
            userDefaultsManager.setUserName(username: userName, password: password, isUserEnter: true)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}



//textField delegate
extension SignUpVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength: Int = 0
        if textField == userNameTF {
            maxLength = 20
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
            
        }else if textField == passwordTF {
            maxLength = 20
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        }else{
            maxLength = 20
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        }
    }
    
}



//configureUI
extension SignUpVC{
    
    fileprivate func configureUI(){
        animationViewConfigure()
        welcomeLblConst()
        usernameTFConst()
        passwordTFConst()
        enterBtnConst()
    }
    
    
    fileprivate func animationViewConfigure(){
        animationView = .init(name: "signUp")
        animationView?.animationSpeed = 1
        baseContainerV.addSubview(animationView!)
        animationView?.play()
        animationView?.loopMode = .loop
        animationView?.frame = CGRect(x: view.frame.width / 2 - 100, y: 40, width: 200, height: 200)
    }
    
    
    fileprivate func welcomeLblConst(){
        view.addSubview(welcomeLbl)
        
        welcomeLbl.top(animationView?.bottomAnchor ?? view.centerYAnchor, 15)
        welcomeLbl.right(view.rightAnchor, -20)
        welcomeLbl.left(view.leftAnchor, 20)
    }
    
    
    fileprivate func usernameTFConst(){
        view.addSubview(userNameTF)
        
        userNameTF.top(welcomeLbl.bottomAnchor, 30)
        userNameTF.left(view.leftAnchor, 20)
        userNameTF.right(view.rightAnchor, -20)
        userNameTF.height(50)
    }
    
    
    fileprivate func passwordTFConst(){
        view.addSubview(passwordTF)
        
        passwordTF.top(userNameTF.bottomAnchor, 30)
        passwordTF.left(view.leftAnchor, 20)
        passwordTF.right(view.rightAnchor, -20)
        passwordTF.height(50)
    }
    
    
    fileprivate func enterBtnConst(){
        view.addSubview(enterBtn)
        
        enterBtn.top(passwordTF.bottomAnchor, 30)
        enterBtn.width(200)
        enterBtn.height(50)
        enterBtn.centerX(view.centerXAnchor)
    }
    
}
