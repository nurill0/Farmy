//
//  ww.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 17/10/22.
//

import Foundation

import UIKit

var appLauncher: AppLauncher?

/// Berilgan UI controller orqali yangi navigation controller yaratadi
/// - Parameter rootVC: root da keluvchi controller
/// - Returns: yakuniy navigation controller
func createNavCtrl(rootVC: UIViewController) -> BaseNavCtrl {
    let navCtrl = BaseNavCtrl(rootViewController: rootVC)
    return navCtrl
}


var safeAreaTop: CGFloat = {
    if #available(iOS 13.0, *) {
        return (UIApplication.shared.windows.first?.safeAreaInsets.top) ?? 0
    } else {
        return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
    }
}()


var safeAreaBottom: CGFloat = {
    
    if #available(iOS 13.0, *) {
        return (UIApplication.shared.windows.first?.safeAreaInsets.bottom) ?? 0
    } else {
        return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    }
}()


func customBarBtnWith(image: String, renderingMode: UIImage.RenderingMode) -> UIButton{
    let img = UIImage(named: image)?.withRenderingMode(renderingMode)
    let btn = UIButton()
    btn.setImage(img, for: .normal)
    btn.tintColor = .darkGray
    btn.frame.size = CGSize(width: CUSTOM_NAV_BAR_WIDTH, height: CUSTOM_NAV_BAR_HEIGHT)
    
    return btn
}




