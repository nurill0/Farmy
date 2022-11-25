//
//  UIFont+extension.swift
//  AT-TARTIL
//
//  Created by Nurillo Domlajonov on 05/10/22.
//

import Foundation
import UIKit

struct AppFont {
    enum FontType: String {
        // Display font type
        case italic = "Inter-Italic"
        case bold = "Inter-Bold"
        case medium = "Inter-Medium"
//        case regular = "Poppins-Regular"
//        case boldItalic = "Poppins-BoldItalic"
//        case italic = "Poppins-Italic"
//        case light = "Poppins-Light"
//        case semibold = "Poppins-SemiBold"
//        case lightItalic = "Poppins-LightItalic"
//        case medium = "Poppins-Medium"
//        case mediumItalic = "Poppins-MediumItalic"
//        case gilroyBold = "Gilroy-Bold"
//        case gilroyMedium = "Gilroy-Medium"
        // Text font type
//        case textBold = "PlusJakartaText-Bold"
//        case textRegular = "PlusJakartaText-Regular"
//        case textBoldItalic = "PlusJakartaText-BoldItalic"
//        case textItalic = "PlusJakartaText-Italic"
//        case textLight = "PlusJakartaText-Light"
//        case textLightItalic = "PlusJakartaText-LightItalic"
        
    }
    
    static func font(type: FontType, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}

// Use: myLabel.font = AppFont.font(type: .Bold, size: 18.0)

//PlusJakartaDisplay-Regular //
//
//PlusJakartaDisplay-Italic //
//
//PlusJakartaDisplay-Light //
//
//PlusJakartaDisplay-LightItalic //
//
//PlusJakartaDisplay-Medium //
//
//PlusJakartaDisplay-MediumItalic //
//
//PlusJakartaDisplay-Bold //
//
//PlusJakartaDisplay-BoldItalic //
//
//PlusJakartaText-Regular //
//
//PlusJakartaText-Italic//
//
//PlusJakartaText-Light//
//
//PlusJakartaText-LightItalic//
//
//PlusJakartaText-Bold //
//
//PlusJakartaText-BoldItalic//
