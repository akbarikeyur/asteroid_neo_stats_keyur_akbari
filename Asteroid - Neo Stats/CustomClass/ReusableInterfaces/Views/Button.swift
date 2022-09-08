//
//  Button.swift
//  TropProf
//
//  Created by Keyur on 21/12/21.
//

import UIKit

@IBDesignable
class Button: UIButton {
    
    @IBInspectable var textColorTypeAdapter : Int32 = 0 {
        didSet {
            self.textColorType = ColorType(rawValue: self.textColorTypeAdapter)
        }
    }
    var textColorType : ColorType? {
        didSet {
            self.setTitleColor(textColorType?.value, for: UIControl.State.normal)
        }
    }
    
//    @IBInspectable var fontTypeAdapter : String = FontType.ARegular.value {
//        didSet {
//            self.fontType = FontType(rawValue: self.fontTypeAdapter)!
//        }
//    }
//    var fontType : FontType = FontType.ARegular {
//        didSet {
//            self.titleLabel?.font = UIFont(name: fontType.value, size: fontSize)!
//        }
//    }
//    
//    @IBInspectable var fontSize : CGFloat = 14 {
//        didSet {
//            self.titleLabel?.font = UIFont(name: fontType.value, size: fontSize)!
//        }
//    }
    
    @IBInspectable var bgColor : UIColor? {
        didSet {
            setBackgroundColor(color: bgColor)
        }
    }
    
    @IBInspectable var borderColor : UIColor? {
        didSet {
            setBorderColor(borderColor: borderColor!)
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            setCornerRadius(cornerRadius)
        }
    }
 
    @IBInspectable var gradientBackgroundTypeAdapter : Int32 = 0 {
        didSet {
            gradientBackgroundType = GradientColorType(rawValue: gradientBackgroundTypeAdapter) ?? .Clear
        }
    }
    var gradientBackgroundType : GradientColorType = .Clear {
        didSet {
            setGradientBackground(gradientBackgroundType: gradientBackgroundType)
        }
    }
    
    @IBInspectable var applyShadow : Bool = false {
        didSet {
            setShadow(applyShadow: applyShadow)
        }
    }
    
    @IBInspectable var tintColorType : UIColor? {
        didSet {
            setTintColor(color: tintColorType)
        }
    }
    
    @IBInspectable open var characterSpacing : CGFloat = 1 {
        didSet {
            let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
            self.setAttributedTitle(attributedString, for: .normal)
        }
        
    }
    
}
