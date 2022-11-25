//
//  UIPageControl+ Custom.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 26/10/22.
//

import Foundation
import UIKit

class BorderedPageControl: UIPageControl {
    
    var selectionColor: UIColor = .black
    
    override var currentPage: Int {
        didSet {
            updateBorderColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        currentPageIndicatorTintColor = selectionColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateBorderColor() {
        if #available(iOS 14.0, *) {
            let smallConfiguration = UIImage.SymbolConfiguration(pointSize: 12.0, weight: .bold)
            let circleFill = UIImage(systemName: "circle.fill", withConfiguration: smallConfiguration)?.withTintColor(  .baseColor(), renderingMode: .alwaysOriginal)
            let circle = UIImage(systemName: "circle", withConfiguration: smallConfiguration)?.withTintColor(  .baseColor(), renderingMode: .alwaysOriginal)
            for index in 0..<numberOfPages {
                if index == currentPage {
                    setIndicatorImage(circleFill, forPage: index)
                } else {
                    setIndicatorImage(circle, forPage: index)
                }
            }
            pageIndicatorTintColor = selectionColor
        } else {
            subviews.enumerated().forEach { index, subview in
                if index != currentPage {
                    subview.layer.borderColor = selectionColor.cgColor
                    subview.layer.borderWidth = 0.7
                } else {
                    subview.layer.borderWidth = 0
                }
            }
        }
    }
}

