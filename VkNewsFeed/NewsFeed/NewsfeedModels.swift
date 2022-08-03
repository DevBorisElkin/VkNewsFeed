//
//  NewsfeedModels.swift
//  VkNewsFeed
//
//  Created by test on 28.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Newsfeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getNewsFeed
                case revealPostIds(postId: Int)
                case getUser
            }
        }
        struct Response {
            enum ResponseType {
                case presentNewsfeed(feed: FeedResponse, revealPostIds: [Int])
                case presentUserInfo(userResponse: UserResponse?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayNewsfeed(feedViewModel: FeedViewModel)
                case displayUser(userViewModel: UserViewModel)
            }
        }
    }
}

struct UserViewModel: TitleViewViewModel {
    var photoUrlString: String?
}

struct FeedViewModel {
    let cells: [Cell]
    
    struct Cell: FeedCellViewModel {
        var postId: Int
        
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String
        var shares: String
        var views: String
        
        var photoAttachements: [FeedCellPhotoAttachmentViewModel]
        var sizes: FeedCellSizes
    }
    
    struct FeedCellPhotoAttachement: FeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
}
