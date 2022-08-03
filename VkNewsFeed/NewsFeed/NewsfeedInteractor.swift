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
    
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    
    private var fether: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        
        switch request {
        case .getNewsFeed:
            print("Interactor: .getNewsFeed")
            fether.getFeed { [weak self] feedResponse in
                guard let feedResponse = feedResponse else { print("Unknwown error"); return } // just for safety
                self?.feedResponse = feedResponse
                self?.presentFeed()
            }
        case .revealPostIds(postId: let postId):
            revealedPostIds.append(postId)
            presentFeed()
        case .getUser:
            fether.getUser { user in
                guard let user = user else {
                    print("Couldn't get user")
                    return
                }
                self.presenter?.presentData(response: .presentUserInfo(userResponse: user))
            }
        }
    }
    
    private func presentFeed(){
        guard let feedResponse = self.feedResponse else { return }
        presenter?.presentData(response: .presentNewsfeed(feed: feedResponse, revealPostIds: revealedPostIds))
    }
}
