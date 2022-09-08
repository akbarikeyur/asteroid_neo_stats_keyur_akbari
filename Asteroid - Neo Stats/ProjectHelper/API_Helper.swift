//
//  API_Helper.swift
//  TropProf
//
//  Created by Keyur on 21/12/21.
//

import Foundation

//MARK: - API
struct API {
    
    static let BASE_URL = "https://api.nasa.gov/neo/rest/v1/"
     
    struct HOME {
        static let feed                  = BASE_URL + "feed"
    }
}
