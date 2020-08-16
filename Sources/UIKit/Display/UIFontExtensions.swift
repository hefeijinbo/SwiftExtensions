//
//  UIFontExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/10.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public enum FontType: String {
    case none = ""
    case regular = "Regular"
    case bold = "Bold"
    case demiBold = "DemiBold"
    case light = "Light"
    case ultraLight = "UltraLight"
    case italic = "Italic"
    case thin = "Thin"
    case book = "Book"
    case roman = "Roman"
    case medium = "Medium"
    case mediumItalic = "MediumItalic"
    case condensedMedium = "CondensedMedium"
    case condensedExtraBold = "CondensedExtraBold"
    case semiBold = "SemiBold"
    case boldItalic = "BoldItalic"
    case heavy = "Heavy"
}

/// EZSwiftExtensions
public enum FontName: String {
    case helveticaNeue
    case helvetica
    case futura
    case menlo
    case avenir
    case avenirNext
    case didot
    case americanTypewriter
    case baskerville
    case geneva
    case gillSans
    case sanFranciscoDisplay
    case seravek
}

public extension UIFont {
    /// 系统字体加粗
    @objc var systemBold: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold)!, size: 0)
    }

    /// 系统字体斜体
    @objc var systemItalic: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitItalic)!, size: 0)
    }
    
    static func getFont(name: FontName, type: FontType, size: CGFloat) -> UIFont {
        let fontName = name.rawValue + "-" + type.rawValue
        if let font = UIFont(name: fontName, size: size) {
            return font
        }
        
        let fontNameNone = name.rawValue
        if let font = UIFont(name: fontNameNone, size: size) {
            return font
        }
        
        let fontNameRegular = name.rawValue + "-" + "Regular"
        if let font = UIFont(name: fontNameRegular, size: size) {
            return font
        }
        
        return UIFont.systemFont(ofSize: size)
    }
}
