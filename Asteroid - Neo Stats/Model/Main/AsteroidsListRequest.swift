//
//  AsteroidsListRequest.swift
//  Asteroid - Neo Stats
//
//  Created by Keyur on 08/09/22.
//

import Foundation

struct AsteroidsListRequest: Codable {
    let start_date: String
    let end_date: String
    let api_key: String
}
