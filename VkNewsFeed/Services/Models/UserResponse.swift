//
//  UserResponse.swift
//  VkNewsFeed
//
//  Created by test on 03.08.2022.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
