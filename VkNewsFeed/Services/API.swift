//
//  API.swift
//  VkNewsFeed
//
//  Created by test on 17.07.2022.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = 5.131
    
    static let newsfeed = "/method/newsfeed.get"
    static let user = "/method/users.get"
}
