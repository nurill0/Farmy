//
//  AppTextFields.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 12/11/22.
//

import Foundation
import UIKit

class AppTextFields: UITextField{
    
    open override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    init(plaseHolder: String, textColor: UIColor, fontSize: Int, borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat, keyBoardType: UIKeyboardType){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = plaseHolder
        self.font = AppFont.font(type: .medium, size: 18)
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.keyboardType = keyBoardType
        self.backgroundColor = .systemBackground
        self.textColor = textColor
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        self.leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
