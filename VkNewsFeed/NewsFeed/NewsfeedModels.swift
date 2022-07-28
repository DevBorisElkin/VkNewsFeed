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
                case some
                case getFeed
            }
        }
        struct Response {
            enum ResponseType {
                case some
                case presentNewsfeed
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayNewsfeed
            }
        }
    }
    
}
