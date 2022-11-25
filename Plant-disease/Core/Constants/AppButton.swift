//
//  Button.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 12/11/22.
//

import Foundation
import UIKit

class AppButton: UIButton{
    
    open override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    init(title: String, fontSize: CGFloat, bgcColor: UIColor, titleColor: UIColor, alignment: NSTextAlignment,tag: Int){
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.textAlignment = alignment
        self.titleLabel?.font = AppFont.font(type: .medium, size: fontSize)
        self.backgroundColor = bgcColor
        self.tag = tag
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
