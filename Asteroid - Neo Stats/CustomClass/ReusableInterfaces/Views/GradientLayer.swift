//
//  GradientLayer.swift
//  TropProf
//
//  Created by Keyur on 21/12/21.
//

import UIKit

class GradientLayer: CAGradientLayer {

    override func layoutSublayers() {
        super.layoutSublayers()
        
        frame = super.bounds
    }
}
