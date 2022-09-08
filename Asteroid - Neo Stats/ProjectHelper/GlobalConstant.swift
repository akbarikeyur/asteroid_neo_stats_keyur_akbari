//
//  GlobalConstant.swift
//  CollectionApp
//
//  Created by MACBOOK on 17/10/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import Foundation
import UIKit

//MARK: - STORYBOARD
struct STORYBOARD {
    static let MAIN = UIStoryboard(name: "Main", bundle: nil)
}

//MARK: - DATE_FORMMATE
enum DATE_FORMMATE : String{
    case DATE1 = "yyyy-MM-dd'T'HH:mm:ssZ"
    case DATE2 = "MM/dd/yyyy"
    case DATE3 = "hh:mm a"
    case DATE4 = "yyyy-MM-dd"
    case DATE5 = "00:01:00Z"
    case DATE6 = "MMM dd, yyyy - hh:mm a"
    case DATE7 = "dd-MMM-yyyy - hh:mm a"
    case DATE8 = "dd-MMM-yyyy"
    case DATE9 = "yyyy-MM-dd'T'HH:mm:00Z"
    case DATE10 = "yyyy-MM-dd'T'00:00:00Z"
    case DATE11 = "yyyy-MM-dd'T'23:59:59Z"
    
    func getValue() ->String {
        return self.rawValue
    }
}

//MARK: - GLOBAL_TITLE
enum GLOBAL_TITLE:String{
    case selecteDate = "Select Start Date"
    case selecteTime = "Select End Time"
    case selectReason = "Select Reason"
    
    func getValue() ->String{
        return self.rawValue
    }
}

//MARK:- DocumentDefaultValues
struct DocumentDefaultValues{
    struct Empty{
        static let string =  ""
        static let int =  0
        static let bool = false
        static let double = 0.0
    }
}
