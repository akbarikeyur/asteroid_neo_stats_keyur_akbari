//
//  HomeViewModel.swift
//  Asteroid - Neo Stats
//
//  Created by Keyur on 08/09/22.
//

import Foundation

protocol HomeViewDelegate {
    
    var homeList: Box<AsteroidsListResponse> { get set }
    func getCatalogueData(_ request: AsteroidsListRequest)
    
}

public class HomeViewModel : HomeViewDelegate {
    
    var homeList: Box<AsteroidsListResponse> = Box(AsteroidsListResponse.init())
    
    func getCatalogueData(_ request: AsteroidsListRequest) {
        
        APIManager.sharedInstance.callGetRequest(api: API.HOME.feed.queryParam(request.toJSON()), Loader: true) { response in
            if response != nil {
                do {
                    let success = try JSONDecoder().decode(AsteroidsListResponse.self, from: response!) // decode the response into model
                    self.homeList.value = success.self
                }
                catch let err {
                    log.error("ERROR OCCURED WHILE DECODING: \(Log.stats()) \(err)")/
                }
            }
        }
    }
}
