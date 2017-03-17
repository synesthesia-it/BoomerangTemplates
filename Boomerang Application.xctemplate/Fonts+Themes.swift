//
//  Fonts.swift
//  ZiaMaria
//
//  Created by Stefano Mondino on 22/11/16.
//  Copyright © 2016 Synesthesia. All rights reserved.
//

import UIKit
typealias Font = UIFont
// @"GaramondClassic-Bold",@"GaramondClassic-BoldItalic",@"GaramondClassic-Italic",@"GaramondClassic-Regular
extension Font {
    static func garamondRegular(ofSize size:CGFloat) -> Font { return Font(name: "GaramondClassicFS-Regular", size: size)!}
    static func garamondBold(ofSize size:CGFloat) -> Font { return Font(name: "GaramondClassicFS-Bold", size: size)!}
    static func garamondItalic(ofSize size:CGFloat) -> Font { return Font(name: "GaramondClassicFS-Italic", size: size)!}
    static func garamondBoldItalic(ofSize size:CGFloat) -> Font { return Font(name: "GaramondClassicFS-BoldItalic", size: size)!}
    
    static func helveticaRegular(ofSize size:CGFloat) -> Font { return Font.systemFont(ofSize: size) }
    static func helveticaBold(ofSize size:CGFloat) -> Font { return Font.boldSystemFont(ofSize: size) }
    static func helveticaItalic(ofSize size:CGFloat) -> Font { return Font.italicSystemFont(ofSize: size) }
    
    static func verdanaRegular(ofSize size:CGFloat) -> Font {
        return Font(name: "Verdana", size: size)!
    }
    static func verdanaBold(ofSize size:CGFloat) -> Font {
        return Font(name: "Verdana-Bold", size: size)!
    }
    static func verdanaItalic(ofSize size:CGFloat) -> Font {
        return Font(name: "Verdana-Italic", size: size)!
    }
}

enum TextStyle {
    case shadow
    case plain
}
extension UILabel{
    func style(_ style:TextStyle, radius:CGFloat? = 8, alpha:Float? = 1) {
        switch style {
        case .shadow:
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.layer.shadowOpacity = alpha!
            self.layer.shadowRadius = radius!
        case .plain:
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.layer.shadowOpacity = 0
            self.layer.shadowRadius = 0
        }
    }
}
