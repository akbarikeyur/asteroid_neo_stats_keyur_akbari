//
//  TableView.swift
//  TropProf
//
//  Created by Keyur on 21/12/21.
//

import Foundation
import UIKit


//MARK:- UITableView
extension UITableView {
    //MARK:- setEmptyMessage
    public func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    //MARK:- sainiRestore
    public func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    
}
