//
//  UIButton+Styles.swift
//  EPTA
//
//  Created by Mohamed Khedr on 16/01/2017.
//  Copyright © 2017 EPTA. All rights reserved.
//

import UIKit


enum ButtonStyle {
    case confirm
    case segmented
    case facebook
    case permissionUnknown
    case permissionEnabled
    case permissionForbidden
    case pdf
    case onlyText
    case confirmLogin

}
extension UIButton {
    func style(_ style:ButtonStyle, textColor:UIColor? = nil, fontSize:CGFloat? = nil) {
        switch style {
        case .confirm:
            let image = UIImage.rectangle(ofSize: CGSize(width:4, height:4), color: .tiffanyBlue).resizableImage(withCapInsets: UIEdgeInsetsMake(2,2,2,2))
            self.setBackgroundImage(image, for: .normal)
            self.titleLabel?.font = Font.verdanaBold(ofSize: 16)
            self.setTitleColor(.white, for: .normal)
            self.contentEdgeInsets = UIEdgeInsetsMake(15,15,15,15)
            
        case .confirmLogin:
            let image = UIImage.rectangle(ofSize: CGSize(width:4, height:4), color: .tiffanyBlue).resizableImage(withCapInsets: UIEdgeInsetsMake(2,2,2,2))
            self.setBackgroundImage(image, for: .normal)
            self.titleLabel?.font = Font.verdanaRegular(ofSize: 14)
            self.setTitleColor(.white, for: .normal)
            self.contentEdgeInsets = UIEdgeInsetsMake(15,15,15,15)
            
        case .segmented:
            let image = UIImage.rectangle(ofSize: CGSize(width:4, height:4), color: .tiffanyBlue).resizableImage(withCapInsets: UIEdgeInsetsMake(2,2,2,2))
            self.setBackgroundImage(image, for: .selected)
            self.titleLabel?.font = Font.systemFont(ofSize: 13)
            self.setTitleColor(.white, for: .selected)
            self.setTitleColor(.saintPatrickBlue, for: .normal)
            self.contentEdgeInsets = UIEdgeInsetsMake(15,15,15,15)
            
        case .facebook:
            let image = UIImage.rectangle(ofSize: CGSize(width:4, height:4), color: .uclaBlue).resizableImage(withCapInsets: UIEdgeInsetsMake(2,2,2,2))
            self.setBackgroundImage(image, for: .normal)
            self.titleLabel?.font = Font.systemFont(ofSize: 14)
            self.setTitleColor(.white, for: .normal)
            self.setImage(UIImage(named:"ic_facebook")?.withRenderingMode(.alwaysOriginal), for: .normal)
            self.normalStateTitle = "login_with_facebook".localized()
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
            self.contentEdgeInsets = UIEdgeInsetsMake(15,15,15,15)
        case .permissionEnabled:
            let image = UIImage.rectangle(ofSize: CGSize(width:4, height:4), color: .uclaBlue).resizableImage(withCapInsets: UIEdgeInsetsMake(2,2,2,2))
            self.setBackgroundImage(image, for: .normal)
            self.titleLabel?.font = Font.systemFont(ofSize: 14)
            self.setTitleColor(.white, for: .normal)
            self.setImage(UIImage(named:"ic_allowed")?.withRenderingMode(.alwaysOriginal), for: .normal)
            self.normalStateTitle = ""
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
            self.contentEdgeInsets = UIEdgeInsetsMake(0,0,0,0)
        case .permissionUnknown:
            let image = UIImage.rectangle(ofSize: CGSize(width:4, height:4), color: UIColor.paleRobinEggBlue).resizableImage(withCapInsets: UIEdgeInsetsMake(2,2,2,2))
            self.setBackgroundImage(image, for: .normal)
            self.titleLabel?.font = Font.systemFont(ofSize: 14)
            self.setTitleColor(.white, for: .normal)
            self.setImage(UIImage(named:"ic_manage")?.withRenderingMode(.alwaysOriginal), for: .normal)
            self.normalStateTitle = ""
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
            self.contentEdgeInsets = UIEdgeInsetsMake(0,0,0,0)
        case .permissionForbidden:
            let image = UIImage.rectangle(ofSize: CGSize(width:4, height:4), color: .uclaBlue).resizableImage(withCapInsets: UIEdgeInsetsMake(2,2,2,2))
            self.setBackgroundImage(image, for: .normal)
            self.titleLabel?.font = Font.systemFont(ofSize: 14)
            self.setTitleColor(.white, for: .normal)
            self.setImage(UIImage(named:"ic_notallowed")?.withRenderingMode(.alwaysOriginal), for: .normal)
            self.normalStateTitle = ""
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
            self.contentEdgeInsets = UIEdgeInsetsMake(0,0,0,0)
        case .pdf:
            let image = UIImage.rectangle(ofSize: CGSize(width:4, height:4), color: .clear).resizableImage(withCapInsets: UIEdgeInsetsMake(2,2,2,2))
            self.setBackgroundImage(image, for: .normal)
            self.titleLabel?.font = Font.verdanaRegular(ofSize: 10)
            self.setTitleColor(.saintPatrickBlue, for: .normal)
            self.contentEdgeInsets = UIEdgeInsetsMake(15,15,15,15)
            
        case .onlyText:
//            let image = UIImage.rectangle(ofSize: CGSize(width:4, height:4), color: .tiffanyBlue).resizableImage(withCapInsets: UIEdgeInsetsMake(2,2,2,2))
//            self.setBackgroundImage(image, for: .normal)
            self.titleLabel?.font = Font.verdanaBold(ofSize: fontSize!)
            self.setTitleColor(textColor, for: .normal)
            self.contentEdgeInsets = UIEdgeInsetsMake(15,15,15,15)
        }
        
    }
    var normalStateTitle : String? {
        get {
            return self.title(for: .normal)
        }
        set {
            UIView.performWithoutAnimation {
                self.setTitle(newValue, for: .normal)
                self.layoutIfNeeded()
            }
            
            
        }
    }
}
