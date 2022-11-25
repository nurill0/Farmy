//
//  AddProductVC.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 03/11/22.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
import Lottie
import FirebaseStorage
import MobileCoreServices






class AddProductVC: BaseVC{
    
    let currentDateTime = Date()
    let userCalendar = Calendar.current
    var animationView: AnimationView?
    private let storage = Storage.storage().reference()
    let userD = UserDefaultsManager.shared
    let dbManager = DatabaseManager.shared
    let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
    
   
    var productImg: UIImage? {
        didSet{
            addImgView.image = productImg
        }
    }
    
    lazy var addImgView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "no-results")?.withTintColor(.titleColors(), renderingMode: .alwaysOriginal)
        img.contentMode = .scaleAspectFit
        img.isHidden = true
        
        return img
    }()
    
    
    lazy var productNameTF: AppTextFields = {
        let tf = AppTextFields(plaseHolder: "Mahsulot nomi", textColor: .titleColors(), fontSize: 18, borderWidth: 2, borderColor: .baseColor(), cornerRadius: 12, keyBoardType: .default)
        tf.placeholder = "Mahsulot nomi"
        
        return tf
    }()
    
    
    lazy var productTypeTF: AppTextFields = {
        let tf = AppTextFields(plaseHolder: "Mahsulot turi", textColor: .titleColors(), fontSize: 18, borderWidth: 2, borderColor: .baseColor(), cornerRadius: 12, keyBoardType: .default)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = "Mahsulot turi"
        tf.delegate = self
        tf.addTarget(self, action: #selector(uploadPhotoFromLibrary), for: .touchUpInside)
        let recog = UITapGestureRecognizer(target: self, action: #selector(getProductType))
        tf.addGestureRecognizer(recog)
        
        return tf
    }()
    
    
    lazy var priceTF: AppTextFields = {
        let tf = AppTextFields(plaseHolder: "Narxi", textColor: .titleColors(), fontSize: 18, borderWidth: 2, borderColor: .baseColor(), cornerRadius: 12, keyBoardType: .numberPad)
        tf.delegate = self
        
        return tf
    }()
    
    
    lazy var productSizeTF: AppTextFields = {
        let tf = AppTextFields(plaseHolder: "Dona", textColor: .titleColors(), fontSize: 18, borderWidth: 2, borderColor: .baseColor(), cornerRadius: 12, keyBoardType: .default)
        tf.text = "Dona"
        tf.delegate = self
        let recog = UITapGestureRecognizer(target: self, action: #selector(getProductSize))
        tf.addGestureRecognizer(recog)
        
        return tf
    }()
    
    
    lazy var typeStackView : UIStackView = {
        let stackV = UIStackView()
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.axis = .vertical
        stackV.spacing = 0
        stackV.distribution = .fillEqually
        stackV.isHidden = true
        stackV.backgroundColor = .systemBackground
        stackV.layer.shadowOffset = CGSize(width: 5, height: 5)
        stackV.layer.shadowRadius = 5
        stackV.layer.shadowOpacity = 0.4
        stackV.layer.borderColor = UIColor.white.cgColor
        stackV.layer.borderWidth = 1
        stackV.alignment = .leading
        
        return stackV
    }()
    
    lazy var addBtn: AppButton = {
        let btn = AppButton(title: "QO'SHISH", fontSize: 20, bgcColor: .baseColor(), titleColor: .white, alignment: .center, tag: 1)
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(addProduct), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var friutBtn: AppButton = {
        let btn = AppButton(title: "  Mevalar", fontSize: 20, bgcColor: .clear, titleColor: .titleColors(), alignment: .left, tag: 1)
        btn.addTarget(self, action: #selector(productType(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var vegetableBtn: AppButton = {
        let btn = AppButton(title: "  Sabzavotlar", fontSize: 20, bgcColor: .clear, titleColor: .titleColors(), alignment: .left, tag: 2)
        btn.addTarget(self, action: #selector(productType(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var watermelonBtn: AppButton = {
        let btn = AppButton(title: "  Poliz-ekinlari", fontSize: 20, bgcColor: .clear, titleColor: .titleColors(), alignment: .left, tag: 3)
        btn.addTarget(self, action: #selector(productType(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var milkBtn: AppButton = {
        let btn = AppButton(title: "  Sut mahsulotlari", fontSize: 20, bgcColor: .clear, titleColor: .titleColors(), alignment: .left, tag: 4)
        btn.addTarget(self, action: #selector(productType(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var sizeStackView : UIStackView = {
        let stackV = UIStackView()
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.axis = .vertical
        stackV.spacing = 0
        stackV.distribution = .fillEqually
        stackV.isHidden = true
        stackV.backgroundColor = .systemBackground
        stackV.layer.shadowOffset = CGSize(width: 5, height: 5)
        stackV.layer.shadowRadius = 5
        stackV.layer.shadowOpacity = 0.4
        stackV.layer.borderColor = UIColor.white.cgColor
        stackV.layer.borderWidth = 1
        stackV.alignment = .leading
        
        return stackV
    }()
    
    
    lazy var numberBtn: AppButton = {
        let btn = AppButton(title: "  Dona", fontSize: 20, bgcColor: .clear, titleColor: .titleColors(), alignment: .left, tag: 1)
        btn.addTarget(self, action: #selector(productSize(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var kilogramBtn: AppButton = {
        let btn = AppButton(title: "  Kilo", fontSize: 20, bgcColor: .clear, titleColor: .titleColors(), alignment: .left, tag: 2)
        btn.addTarget(self, action: #selector(productSize(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var litrBtn: UIButton = {
        let btn = AppButton(title: "  Litr", fontSize: 20, bgcColor: .clear, titleColor: .titleColors(), alignment: .left, tag: 3)
        btn.addTarget(self, action: #selector(productSize(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var valuteLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints  =  false
        lbl.text = "so'm"
        lbl.textAlignment = .center
        lbl.textColor = UIColor.baseColor()
        lbl.font = AppFont.font(type: .medium, size: 22)
        
        return lbl
    }()
    
    
}



//lifecycle uchun extension
extension AddProductVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView = .init(name: "addproduct")
        configureUI()
        view.backgroundColor = .systemBackground
        baseContainerV.backgroundColor = .systemBackground
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        self.navigationItem.leftBarButtonItem = self.backBarBtn
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "uploadPhoto")?.withTintColor(.baseColor(), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(uploadPhotoFromLibrary))
        self.baseNavbarTitleLbl.textColor = .baseColor()
        
    }
    
}



//button actionlari uchun extension
extension AddProductVC{
    
    
    ///mahsulot ma'lumotlarini olish va dbga yuborish uchun funksiya
    @objc func addProduct(){
        var num = userD.getImgNum()
        num+=1
        userD.setImgNum(imgNum: num)
        
        guard let name =  productNameTF.text, !name.isEmpty else {
            showErrorInfoAlert()
            return}
        guard let type =  productTypeTF.text, !name.isEmpty else {
            showErrorInfoAlert()
            return}
        guard let price =  priceTF.text, !name.isEmpty else {
            showErrorInfoAlert()
            return}
        guard let size =  productSizeTF.text, !name.isEmpty else {
            showErrorInfoAlert()
            return}
        guard let userImage = addImgView.image else {
            showErrorInfoAlert()
            return}
        
        dbManager.addImg(userName: self.userD.getUsername(), imgDate: self.timestamp, imgData: userImage, name: name, typeAndCatergory: type, price: price, per: size, userNameAndDate: "\(userD.getUsername())\(userD.getImgNum())", id: userD.getImgNum())
        
        if productTypeTF.text != "Mahsulot turi" && productSizeTF.text != "Dona" {
            DispatchQueue.main.async { [self] in
//                self.dbManager.getProduct(productType: type, userAndId: "\(userD.getUsername())\(userD.getImgNum())")
                self.showSaveInfoAlert()
            }
        }else{
            showErrorInfoAlert()
        }
    }
    
    
    ///maxsulot rasmini tanlab olish uchun funksiya
    @objc func uploadPhotoFromLibrary(){
        let vc = UIImagePickerController()
        animationView?.isHidden = true
        addImgView.isHidden = false
        animationView?.stop()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    
    ///maxsulot turi ro'yxatini chiqarish uchun funksiya
    @objc func getProductType(){
        typeStackView.isHidden = false
    }
    
    
    ///maxsulot miqdor o'lchamini ro'yxatini chiqarish uchun funksiya
    @objc func getProductSize(){
        sizeStackView.isHidden = false
    }
    
    
    ///Mahsulotni  turini oluvchi f-ya
    @objc func productType(sender: UIButton){
        switch sender.tag {
        case 1:
            productTypeTF.text = "Mevalar"
            typeStackView.isHidden = true
        case 2:
            productTypeTF.text = "Sabzavotlar"
            typeStackView.isHidden = true
        case 3:
            productTypeTF.text = "Poliz-ekinlari"
            typeStackView.isHidden = true
        case 4:
            productTypeTF.text = "Sut mahsulotlari"
            typeStackView.isHidden = true
        default:
            productTypeTF.text = "Mahsulot turi"
        }
    }
    
    
    ///Mahsulotni miqdor turini oluvchi f-ya
    @objc func productSize(sender: UIButton){
        switch sender.tag {
        case 1:
            productSizeTF.text = "Dona  "
            sizeStackView.isHidden = true
        case 2:
            productSizeTF.text = "Kilo  "
            sizeStackView.isHidden = true
        case 3:
            productSizeTF.text = "Litr  "
            sizeStackView.isHidden = true
        default:
            productSizeTF.text = "Mahsulot turi"
        }
    }
    
    
    func showSaveInfoAlert(){
        let alert = UIAlertController(title: "Saqlandi ✅", message: "Siz kiritgan ma'lumotlar muvofaqqiyatli saqlandi.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Davom ettirish", style: .default, handler: { al in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    
    func showErrorInfoAlert(){
        let alert = UIAlertController(title: "Xatolik", message: "Iltimos ma'lumotlarni to'liq kiriting", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Davom ettirish", style: .default))
        present(alert, animated: true)
    }
    
}



//UI
extension AddProductVC{
    
    
    fileprivate func configureUI(){
        configureAnimationView()
        addBtnConst()
        extractedFunc()
        productTypeTFConst()
        productSizeTFConst()
        valuteLblConst()
        priceTFConst()
        sizeStackVConst()
        addImgConst()
        typeStackVConst()
    }
    
    
    func configureAnimationView(){
        animationView?.animationSpeed = 1
        view.addSubview(animationView!)
        animationView?.play()
        animationView?.loopMode = .loop
        if self.view.frame.height >= 812{
            animationView?.frame = CGRect(x: view.frame.width / 2 - 125, y: 60, width: 250, height: 250)
        }else{
            animationView?.frame = CGRect(x: view.frame.width / 2 - 100, y: 20, width: 200, height: 200)
        }
    }
    
    
    fileprivate func addImgConst(){
        view.addSubview(addImgView)
        
        addImgView.top(self.view.safeAreaLayoutGuide.topAnchor, 20)
        addImgView.centerX(view.centerXAnchor)
        if self.view.frame.height >= 812{
            addImgView.height(200)
            addImgView.width(200)
            
        }else{
            addImgView.height(150)
            addImgView.width(150)
        }
    }
    
    
    fileprivate func typeStackVConst(){
        view.addSubview(typeStackView)
        view.bringSubviewToFront(typeStackView)
        
        typeStackView.addArrangedSubview(friutBtn)
        typeStackView.addArrangedSubview(vegetableBtn)
        typeStackView.addArrangedSubview(watermelonBtn)
        typeStackView.addArrangedSubview(milkBtn)
        typeStackView.bottom(productTypeTF.topAnchor, -5)
        typeStackView.right(productTypeTF.rightAnchor)
        typeStackView.left(productTypeTF.leftAnchor, 10)
        typeStackView.height(200)
    }
    
    
    fileprivate func sizeStackVConst(){
        view.addSubview(sizeStackView)
        
        sizeStackView.addArrangedSubview(numberBtn)
        sizeStackView.addArrangedSubview(kilogramBtn)
        sizeStackView.addArrangedSubview(litrBtn)
        sizeStackView.bottom(productSizeTF.topAnchor)
        sizeStackView.right(productSizeTF.rightAnchor)
        sizeStackView.left(productSizeTF.leftAnchor, 5)
        sizeStackView.height(150)
        
    }
    
    
    fileprivate func addBtnConst(){
        view.addSubview(addBtn)
        
        if self.view.frame.height >= 812{
            addBtn.bottom(view.bottomAnchor, -30)
        }else{
            addBtn.bottom(view.bottomAnchor, -10)
        }
        addBtn.centerX(view.centerXAnchor)
        addBtn.height(50)
        addBtn.width(200)
    }
    
    
    fileprivate func priceTFConst() {
        view.addSubview(priceTF)
        
        priceTF.top(productTypeTF.bottomAnchor, 20)
        priceTF.right(valuteLbl.leftAnchor, -5)
        priceTF.left(view.leftAnchor, 20)
        priceTF.height(50)
    }
    
    
    fileprivate func valuteLblConst() {
        view.addSubview(valuteLbl)
        
        valuteLbl.right(productSizeTF.leftAnchor, -5)
        valuteLbl.centerY(productSizeTF.centerYAnchor)
        valuteLbl.width(50)
    }
    
    
    fileprivate func productSizeTFConst() {
        view.addSubview(productSizeTF)
        
        productSizeTF.top(productTypeTF.bottomAnchor, 20)
        productSizeTF.right(view.rightAnchor, -20)
        productSizeTF.width(120)
        productSizeTF.height(50)
    }
    
    
    fileprivate func productTypeTFConst() {
        view.addSubview(productTypeTF)
        
        productTypeTF.top(productNameTF.bottomAnchor, 20)
        productTypeTF.right(view.rightAnchor, -20)
        productTypeTF.left(view.leftAnchor, 20)
        productTypeTF.height(50)
    }
    
    
    fileprivate func extractedFunc() {
        view.addSubview(productNameTF)
        
        productNameTF.top(animationView?.bottomAnchor ?? addImgView.bottomAnchor, 40)
        productNameTF.right(view.rightAnchor, -20)
        productNameTF.left(view.leftAnchor, 20)
        productNameTF.height(50)
    }
    
}



//textfield
extension AddProductVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == priceTF{
            let maxLength = 7
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        }else if textField == productTypeTF || textField == productSizeTF {
            return false
        }else{
            let maxLength = 20
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        }
    }
    
}



//photo edit
extension AddProductVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        addImgView.image = image
        productImg = image
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true )
    }
    
    
}



//stackView
extension UIStackView {
    
    func setHeightPercentageFill(values: [CGFloat]) {
        guard values.count == arrangedSubviews.count else { return }
        axis = .vertical
        distribution = .fillProportionally
        for i in 1..<arrangedSubviews.count {
            arrangedSubviews[i].heightAnchor.constraint(equalToConstant: frame.height * values[i]).isActive = true
        }
    }
    
}
