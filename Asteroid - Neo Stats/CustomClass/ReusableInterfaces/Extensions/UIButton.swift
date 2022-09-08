//
//  UIButton.swift
//  TropProf
//
//  Created by Keyur on 21/12/21.
//

import UIKit

extension UIButton {
    
    private func actionHandler(action:(() -> Void)? = nil) {
        struct __ { static var action :(() -> Void)? }
        if action != nil { __.action = action }
        else { __.action?() }
    }
    
    @objc private func triggerActionHandler() {
        self.actionHandler()
    }
    
    func actionHandler(controlEvents control :UIControl.Event, ForAction action:@escaping () -> Void) {
        self.actionHandler(action: action)
        self.addTarget(self, action: #selector(triggerActionHandler), for: control)
    }
}

@objc class ClosureSleeve: NSObject {
    let closure: ()->()

    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }

    @objc func invoke () {
        closure()
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "[\(arc4random())]", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
