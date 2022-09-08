//
//  Array+RUI.swift
//  TropProf
//
//  Created by Keyur on 21/12/21.
//

import UIKit

extension Array {
  mutating func removeObject<U: Equatable>(object: U) -> Bool {
    for (idx, objectToCompare) in self.enumerated() {
      if let to = objectToCompare as? U {
        if object == to {
            self.remove(at: idx)
          return true
        }
      }
    }
    return false
  }
    
    func containsObject<U: Equatable>(object : U) -> Bool {
        for (_, objectToCompare) in self.enumerated() {
            if let to = objectToCompare as? U {
                if object == to {
                    return true
                }
            }
        }
        return false
    }
    
    func before(value1: String, value2: String) -> Bool {
         return value1 < value2;
    }

    
}
