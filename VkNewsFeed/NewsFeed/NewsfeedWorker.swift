//
//  NewsfeedWorker.swift
//  VkNewsFeed
//
//  Created by test on 28.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NewsfeedService {
    var authService: AuthService
    var networking: Networking
    var fetcher: DataFetcher
    
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    
    init() {
        self.authService = SceneDelegate.shared().authService
        self.networking = NetworkService(authService: authService)
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getUser(completion: @escaping (UserResponse?) -> Void){
        fetcher.getUser { userResponse in
            completion(userResponse)
        }
    }
    
    func getFeed(completion: @escaping ([Int], FeedResponse) -> Void){
        fetcher.getFeed { [weak self] feed in
            
            self?.feedResponse = feed
            guard let feedResponse = self?.feedResponse else {
                return
            }
            completion(self!.revealedPostIds, feedResponse)
        }
    }
    
    func revealPostIds(forPostId postId: Int, completion: @escaping ([Int], FeedResponse) -> Void){
        revealedPostIds.append(postId)
        guard let feedResponse = self.feedResponse else { return }
        completion(revealedPostIds, feedResponse)
    }
}
