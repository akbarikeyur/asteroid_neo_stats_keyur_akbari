//
//  View.swift
//  TropProf
//
//  Created by Keyur on 21/12/21.
//

import UIKit

@IBDesignable
class View: UIView {
    
    @IBInspectable var bgColor : UIColor? {
        didSet {
            setBackgroundColor(color: bgColor)
        }
    }
    
    @IBInspectable var gradientBackgroundTypeAdapter : Int32 = 0 {
        didSet {
            gradientBackgroundType = GradientColorTypeForView(rawValue: gradientBackgroundTypeAdapter) ?? .Clear
        }
    }
    var gradientBackgroundType : GradientColorTypeForView = .Clear {
        didSet {
            setGradientBackground1(gradientBackgroundType: gradientBackgroundType)
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
    
    @IBInspectable var applyShadow : Bool = false {
        didSet {
            setShadow(applyShadow: applyShadow)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setGradientBackground1(gradientBackgroundType: gradientBackgroundType)
    }
    
//    @IBInspectable open var cornerEdges : CGFloat = 0
//    @IBInspectable  var topLeft: Bool = false
//    @IBInspectable  var topRight: Bool = false
//    @IBInspectable  var bottomLeft: Bool = false
//    @IBInspectable  var bottomRight: Bool = false
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        var options = UIRectCorner()
//        if topLeft {
//            options =  options.union(.topLeft)
//        }
//        if topRight {
//            options =  options.union(.topRight)
//        }
//        if bottomLeft {
//            options =  options.union(.bottomLeft)
//        }
//        if bottomRight {
//            options =  options.union(.bottomRight)
//        }
//
//        setRoundCorners(options, radius: cornerEdges)
//    }
}

extension UIView {
    func setBackgroundColor(color : UIColor?) {
        backgroundColor = color
    }
    
    func setBorderColor(borderColor : UIColor) {
        self.layer.borderColor = borderColor.cgColor
    }
    
    func setBorderWidth(width : CGFloat) {
        self.layer.borderWidth = width
    }
    
    func setTintColor(color : UIColor?) {
        self.tintColor = color
    }
    
    func setCornerRadius(_ cornerRadius : CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func setShadow(applyShadow : Bool) {
        if applyShadow {
            self.layer.masksToBounds = false;
            self.layer.shadowOffset = CGSize(width: 0.5, height: 1.5)
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowRadius = 2
        } else {
            self.layer.shadowRadius = 0
            self.layer.shadowColor = UIColor.clear.cgColor
        }
    }
    
    func setGradientBackground(gradientBackgroundType : GradientColorType) {
        
        if gradientBackgroundType == .Clear {
            return
        }
        
        if let gradient = self.layer.value(forKeyPath: "GradientLayer") as? GradientLayer {
            gradient.frame = self.bounds
            return
        }
        
        let layer = gradientBackgroundType.layer
        layer.frame = self.bounds
        
        self.layer.insertSublayer(layer, at: 0)
        self.layer.setValue(layer, forKey: "GradientLayer")
    }
    
    func setGradientBackground1(gradientBackgroundType : GradientColorTypeForView) {
        
        if gradientBackgroundType == .Clear {
            return
        }
        
        if let gradient = self.layer.value(forKeyPath: "GradientLayer") as? GradientLayer {
            gradient.frame = self.bounds
            return
        }
        
        let layer = gradientBackgroundType.layer
        layer.frame = self.bounds
        
        self.layer.insertSublayer(layer, at: 0)
        self.layer.setValue(layer, forKey: "GradientLayer")
    }
    
    
    func setRoundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
