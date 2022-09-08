//
//  Lable.swift
//  TropProf
//
//  Created by Keyur on 21/12/21.
//

import UIKit

extension UILabel {
    func getHeight() -> CGFloat{
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: .greatestFiniteMagnitude))
        label.numberOfLines = self.numberOfLines
        label.text = self.text
        label.font = self.font
        label.sizeToFit()
        return label.frame.height
    }
}


extension NSMutableAttributedString {
    func setColorForText(textToFind: String, withColor color: UIColor) {
     let range: NSRange = self.mutableString.range(of: textToFind, options: .caseInsensitive)
      if range != nil {
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
      }
    }
}
