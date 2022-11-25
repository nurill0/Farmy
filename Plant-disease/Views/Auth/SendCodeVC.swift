//
//  SendCodeVC.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 26/10/22.
//

import Foundation
import UIKit
import Lottie
import Firebase

var codeIsSend = false

protocol GetPhoneNumber{
    var mobilePhoneNumber: String {get set}
}

class SendCodeVC: BaseVC, GetPhoneNumber{
    
    let defaults = UserDefaultsManager.shared
    var verificationId: String = ""
    var mobilePhoneNumber: String = ""
    var animationView: AnimationView?
    
    
    lazy var phoneTF: AppTextFields = {
        let tf = AppTextFields(plaseHolder: "", textColor: .baseColor(), fontSize: 20, borderWidth: 2, borderColor: UIColor.baseColor(), cornerRadius: 15, keyBoardType: .phonePad)
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 50))
        tf.delegate = self
        tf.leftViewMode = .always
        
        return tf
    }()
    
    lazy var phoneImgV: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "phone")?.withRenderingMode(.alwaysOriginal).withTintColor(.baseColor())
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    lazy var phoneLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "+998"
        lbl.textAlignment = .left
        lbl.textColor = .baseColor()
        lbl.font = AppFont.font(type: .medium, size: 20)
        
        return lbl
    }()
    
    lazy var confirmBtn: AppButton = {
        let btn = AppButton(title: "Tasdiqlash".uppercased(), fontSize: 18, bgcColor: .baseColor(), titleColor: .white, alignment: .center, tag: 0)
        btn.layer.cornerRadius = 18
        btn.addTarget(self, action: #selector(codeConfirm), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var signInBtn: AppButton = {
        let btn = AppButton(title: "Hisobingizga kiring", fontSize: 15, bgcColor: .clear, titleColor: .baseColor(), alignment: .center, tag: 0)
        btn.addTarget(self, action: #selector(goSignIn), for: .touchUpInside)
        
        return btn
    }()
    
}



//lifecycle
extension SendCodeVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = self.backBarBtn
        self.navigationItem.titleView = customNavTitleV
    }
    
}



//functions
extension SendCodeVC{
    
    @objc func codeConfirm(){
        if phoneTF.text?.isEmpty != true{
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
            guard let number = phoneTF.text, !number.isEmpty else{
                return
            }
            mobilePhoneNumber = number
            let phoneNumber = number.removeCharacters(from: CharacterSet.decimalDigits.inverted)
            registerWithFireBase(phoneNum: "+998"+phoneNumber, verificationID: verificationId ) { [weak self] success in
                guard success else {return}
                
                DispatchQueue.main.async {
                    let vc = CodeConfirmationController()
                    indicator.stopAnimating()
                    indicator.isUserInteractionEnabled = true
                    indicator.hidesWhenStopped = true
                    vc.modalPresentationStyle = .fullScreen
                    vc.delegate = self
                    vc.vericifID = self?.verificationId
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }else{
            return
        }
    }
    
    
    @objc func goSignIn(){
        let vc = SignUpVC()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func registerWithFireBase(phoneNum: String,verificationID: String,completion: @escaping (Bool)->Void){
        Auth.auth().languageCode = "uz"
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNum, uiDelegate: nil){ verifiationID, error in
            print("Code Send")
            if let error = error {
                print("ERRRRORRR")
                print(error.localizedDescription)
                completion(false)
                return
            }
            let vc = CodeConfirmationController()
            self.defaults.setPhoneNumber(userPhoneNumber: phoneNum)
            vc.vericifID = verifiationID
            self.verificationId = verifiationID ?? ""
            codeIsSend = true
            completion(true)
        }
    }
    
}



//configure ui
extension SendCodeVC{
    
    
    fileprivate func configureUI(){
        animationViewConfigure()
        signInBtnConst()
        confirmBtnConst()
        phoneTFConst()
        phoneImgVConst()
        phoneLblConst()
    }
    
    
    fileprivate func animationViewConfigure(){
        animationView = .init(name: "sendCode")
        animationView?.animationSpeed = 1
        baseContainerV.addSubview(animationView!)
        animationView?.play()
        animationView?.loopMode = .loop
        animationView?.frame = CGRect(x: view.frame.width / 2 - 150, y: 80, width: 300, height: 300)
    }
    
    
    fileprivate func signInBtnConst(){
        view.addSubview(signInBtn)
        
        signInBtn.bottom(view.bottomAnchor, -20)
        signInBtn.width(200)
        signInBtn.height(30)
        signInBtn.centerX(view.centerXAnchor)
    }
    
    
    fileprivate func confirmBtnConst(){
        view.addSubview(confirmBtn)
        
        confirmBtn.bottom(signInBtn.topAnchor, -30)
        confirmBtn.width(200)
        confirmBtn.height(50)
        confirmBtn.centerX(view.centerXAnchor)
    }
    
    
    fileprivate func phoneTFConst(){
        view.addSubview(phoneTF)
        
        phoneTF.bottom(confirmBtn.topAnchor, -30)
        phoneTF.right(view.rightAnchor, -20)
        phoneTF.left(view.leftAnchor, 20)
        phoneTF.height(55)
    }
    
    
    fileprivate func phoneImgVConst(){
        phoneTF.addSubview(phoneImgV)
        
        phoneImgV.left(phoneTF.leftAnchor, 8)
        phoneImgV.centerY(phoneTF.centerYAnchor)
        phoneImgV.width(20)
        phoneImgV.height(20)
    }
    
    
    fileprivate func phoneLblConst(){
        phoneTF.addSubview(phoneLbl)
        
        phoneLbl.left(phoneImgV.rightAnchor, 8)
        phoneLbl.centerY(phoneTF.centerYAnchor)
        phoneLbl.height(20)
    }
    
}



//TextField delegate
extension SendCodeVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText:String = textField.text else {return true}
        if string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil { return false }
        let newCount:Int = currentText.count + string.count - range.length
        let addingCharacter:Bool = range.length <= 0
        
        if(newCount == 3){
            textField.text = addingCharacter ? currentText + "-\(string)" : String(currentText.dropLast(2))
            return false
        }else if(newCount == 7){
            textField.text = addingCharacter ? currentText + "-\(string)" : String(currentText.dropLast(2))
            return false
        }else if(newCount == 10){
            textField.text = addingCharacter ? currentText + "-\(string)" : String(currentText.dropLast(2))
            return false
        }
        if(newCount > 12){
            return false
        }
        return true
    }
    
}
