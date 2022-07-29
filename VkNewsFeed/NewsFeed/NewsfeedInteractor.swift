//
//  NewsfeedInteractor.swift
//  VkNewsFeed
//
//  Created by test on 28.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
    func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {
    
    var presenter: NewsfeedPresentationLogic?
    var service: NewsfeedService? // Worker
    
    private var fether: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        
        switch request {
        case .getNewsFeed:
            print("Interactor: .getNewsFeed")
            fether.getFeed { [weak self] feedResponse in
                
                guard let feedResponse = feedResponse else { print("Unknwown error"); return }
                
                self?.presenter?.presentData(response: .presentNewsfeed(feed: feedResponse))
            }
        }
    }
}
