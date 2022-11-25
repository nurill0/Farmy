//
//  CodeConfirmationController.swift
//  RTO
//
//  Created by Nurillo Domlajonov on 06/07/22.
//

import UIKit
import FirebaseAuth
import Lottie
import IQKeyboardManagerSwift


class CodeConfirmationController: BaseVC {
    
    let userDefaultsManager = UserDefaultsManager.shared
    var isCodeCome = false
    var time = 60
    var delegate: GetPhoneNumber?
    var timer: Timer!
    var isShowAlert = false
    var animationView: AnimationView?
    var vericifID: String?
    var indicator = 0
    var textFieldBank: [UITextField] = []
    
    
    lazy var userPhoneNumLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Sizning telefon raqamingiz\n+998 \(delegate?.mobilePhoneNumber)"
        lbl.textAlignment = .center
        lbl.font = AppFont.font(type: .medium, size: 20)
        lbl.numberOfLines = 0
        lbl.textColor = .baseColor()
        
        return lbl
    }()
    
    lazy var timeLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Kod yaroqlik muddati \(time) soniya"
        lbl.font = AppFont.font(type: .medium, size: 18)
        lbl.textColor = .baseColor()
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var confirmBtn: AppButton = {
        let btn = AppButton(title: "TASDIQLASH", fontSize: 20, bgcColor: .baseColor(), titleColor: .white, alignment: .center, tag: 0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 18
        
        return btn
    }()
   
    lazy var stackView : UIStackView = {
        let stackV = UIStackView()
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.distribution = .fillEqually
        stackV.alignment = .fill
        stackV.backgroundColor = .systemBackground
        stackV.spacing = 15
        
        return stackV
    }()
    
}



//lifecycle
extension CodeConfirmationController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        guard let phone = delegate?.mobilePhoneNumber else {
            return
        }
        userPhoneNumLbl.text = "Sizning telefon raqamingiz\n+998 \(phone)"
        navigationItem.hidesBackButton = true
        confirmBtn.addTarget(self, action: #selector(getCodeConfirm), for: .touchUpInside)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeCount), userInfo: nil, repeats: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
    }
    
}


// MARK: - Actions
extension CodeConfirmationController{
    
    @objc func timeCount(){
        time-=1
        timeLbl.text = "Kod yaroqlik muddati \(time) soniya"
        DispatchQueue.main.asyncAfter(deadline: .now()+59) { [self] in
            if userDefaultsManager.getUserIsEntered() == false {
                showTimeAlert()
            }else{
                print("Success entered the account")
            }
            time = 0
            timer.invalidate()
        }
    }
    
    
    @objc func getCodeConfirm(){
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

        var verificationCode = ""
        for tf in textFieldBank {
            verificationCode.append(tf.text ?? "")
        }
        codeConfirm(code: verificationCode, verificationID: vericifID ?? "") { [weak self] success in
            guard success else {
                print("Shu yerga chiqaremi")
                self?.showAlert()
                self?.isCodeCome = false
                return}
            self?.isCodeCome = true
            DispatchQueue.main.async {
                indicator.stopAnimating()
                indicator.isUserInteractionEnabled = true
                indicator.hidesWhenStopped = true
                let vc = SignUpVC()
                vc.modalPresentationStyle = .fullScreen
                self?.navigationController?.pushViewController(vc, animated: true)
                self?.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
                self?.navigationItem.hidesBackButton = true
            }
        }
    }
    
    
    func codeConfirm(code: String,verificationID: String,completion: @escaping (Bool)->Void){
        Auth.auth().languageCode = "uz"
        let creditional = PhoneAuthProvider.provider().credential(withVerificationID: vericifID ?? "", verificationCode: code)
        Auth.auth().signIn(with: creditional){ authresult, error in
            if let error = error{
                print(error.localizedDescription)
                completion(false)
                print("Code send")
                self.isShowAlert = true
                return
            }
            self.isShowAlert = false
            completion(true)
        }
    }
    
    
    func showAlert(){
        let alert = UIAlertController(title: "Xatolik", message: "Kiritilgan kod noto`g`ri ", preferredStyle: UIAlertController.Style.alert)
        alert.setValue(NSAttributedString(string: "Xato", attributes: [.foregroundColor : UIColor.red]), forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { [self] aler in
            
        }))
        self.present(alert, animated: true,completion: nil)
    }
    
    
    func showTimeAlert(){
        let alert = UIAlertController(title: "Xatolik", message: "Qaytadan urinib ko`ring!", preferredStyle: UIAlertController.Style.alert)
        alert.setValue(NSAttributedString(string: "Kod yaroqlilik muddati tugadi", attributes: [.foregroundColor : UIColor.red]), forKey: "attributedTitle")
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { aler in
            self.timer.invalidate()
            self.navigationController?.popViewController(animated: true)
            self.timer.invalidate()
        }))
        self.present(alert, animated: true,completion: nil)
    }
    
}



// MARK: - UI
extension CodeConfirmationController{
    
    fileprivate func initViews(){
        confirmBtnConst()
        timeLblConst()
        stackVConstAndCOnfigure()
        phoneNumConst()
        animationViewConfigure()
    }
    
    
    fileprivate func confirmBtnConst(){
        view.addSubview(confirmBtn)
        
        confirmBtn.bottom(view.bottomAnchor, -30)
        confirmBtn.right(view.rightAnchor, -20)
        confirmBtn.left(view.leftAnchor, 20)
        confirmBtn.height(50)
    }
    
    
    fileprivate func timeLblConst(){
        view.addSubview(timeLbl)
        
        timeLbl.bottom(confirmBtn.topAnchor, -30)
        timeLbl.right(view.rightAnchor, -20)
        timeLbl.left(view.leftAnchor, 20)
    }
    
    
    fileprivate func stackVConstAndCOnfigure(){
        view.addSubview(stackView)
        
        stackView.bottom(timeLbl.topAnchor, -30)
        stackView.left(view.leftAnchor, 20)
        stackView.right(view.rightAnchor, -20)
        stackView.height(45)
        
        for index in 0..<6{
            let tf = UITextField()
            tf.backgroundColor = .systemBackground
            tf.textColor = UIColor.titleColors()
            tf.font = AppFont.font(type: .medium, size: 22)
            tf.layer.cornerRadius =  10
            tf.keyboardType = .numberPad
            tf.layer.borderWidth = 2
            tf.layer.borderColor = UIColor.baseColor().cgColor
            tf.placeholder = "-"
            tf.textAlignment = .center
            tf.tag = index
            tf.delegate = self
            stackView.addArrangedSubview(tf)
            textFieldBank.append(tf)
        }
    }
    
    
    fileprivate func phoneNumConst(){
        view.addSubview(userPhoneNumLbl)
        
        userPhoneNumLbl.bottom(stackView.topAnchor, -30)
        userPhoneNumLbl.right(view.rightAnchor, -20)
        userPhoneNumLbl.left(view.leftAnchor, 20)
    }
    
    
    fileprivate func animationViewConfigure(){
        animationView = .init(name: "codeConfirmation")
        animationView?.animationSpeed = 1
        baseContainerV.addSubview(animationView!)
        animationView?.play()
        animationView?.loopMode = .loop
        animationView?.frame = CGRect(x: view.frame.width / 2 - 125, y: 60, width: 250, height: 250)
    }

}



//MARK: Textfield delegate
extension CodeConfirmationController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        indicator = textField.tag
        textFieldBank[indicator].text = string
        if string == ""{
            indicator-=1
            textField.layer.borderWidth = 2
        }else{
            textFieldBank[indicator].text = string
            indicator+=1
            textField.layer.borderWidth = 2
        }
        if indicator == 6 || indicator == -1{
            indicator = 0
            textFieldBank[5].resignFirstResponder()
        }else{
            textFieldBank[indicator].becomeFirstResponder()
            
        }
        return false
    }
}
