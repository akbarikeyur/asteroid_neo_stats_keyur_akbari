//
//  Colors.swift
//  TropProf
//
//  Created by Keyur on 21/12/21.
//

import UIKit

var ClearColor : UIColor = UIColor.clear //0
var WhiteColor : UIColor = UIColor.init(named: "White")! //1
var DarkTextColor : UIColor = UIColor.init(named: "DarkText")! //2
var ExtraLightGrayColor = UIColor.init(named: "ExtraLightGray")!//3
var RedColor = UIColor.init(named: "Red")!
var GreenColor = UIColor.init(named: "Green")!

enum ColorType : Int32 {
    case Clear = 0
    case White = 1
    case DarkText = 2
    case ExtraLightGray = 3
}

extension ColorType {
    var value: UIColor {
        get {
            switch self {
                case .Clear: //0
                    return ClearColor
                case .White: //1
                    return WhiteColor
                case .DarkText: //3
                    return DarkTextColor
                case .ExtraLightGray: //3
                    return ExtraLightGrayColor
            }
        }
    }
}

enum GradientColorType : Int32 {
    case Clear = 0
    case Login = 1
}

extension GradientColorType {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .Login: //1
                gradient.colors = [
                    colorFromHex(hex: "06BD8C").cgColor,
                    colorFromHex(hex: "05A191").cgColor  //089B97
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
                gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
//                gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
//                gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
            }
            
            return gradient
        }
    }
}


enum GradientColorTypeForView : Int32 {
    case Clear = 0
    case App = 1
}

extension GradientColorTypeForView {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .App: //1
                gradient.colors = [
                    colorFromHex(hex: "#00AF80").cgColor,
                    colorFromHex(hex: "#06BD8C").cgColor,
                    colorFromHex(hex: "#08969C").cgColor
                ]
                gradient.locations = [0.0, 0.5, 1.0]
                gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
                gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            }
            
            return gradient
        }
    }
}

