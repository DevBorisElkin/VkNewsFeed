//
//  FeedResponse.swift
//  VkNewsFeed
//
//  Created by test on 22.07.2022.
//

import Foundation

struct FeedResponseWrapped: Decodable{
    let response: FeedResponse
}

struct FeedResponse: Decodable{
    var items: [FeedItem]
    var profiles: [Profile]
    var groups: [Group]
    var nextFrom: String?
}

struct FeedItem: Decodable{
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
    let attachments: [Attachment]?
}

struct Attachment: Decodable {
    let photo: Photo?
}

struct Photo: Decodable {
    let sizes: [PhotoSize]
    
    var height: Int {
        return getProperSize().height
    }
    var width: Int {
        return getProperSize().width
    }
    
    var srcBIG: String {
        return getProperSize().url
    }
    
    private func getProperSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x" }){
            return sizeX
        } else if let fallbackSize = sizes.last{
            return fallbackSize
        }
        return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
    }
}

struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}



struct CountableItem: Decodable{
    let count: Int
    
}

protocol ProfileRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct Profile: Decodable, ProfileRepresentable{
    let id: Int
    let firstName: String
    let lastName: String
    let photo50: String?
    let photo100: String
    let photo200: String?
    let photo200orig: String?
    let photo400orig: String?
    let screenName: String?
    
    var name: String { return firstName + " " + lastName}
    var photo: String { return photo100 }
}

struct Group: Decodable, ProfileRepresentable{
    let id: Int
    let isClosed: Int?
    let name: String
    let photo100: String
    let photo200: String?
    let photo50: String?
    let screenName: String?
    
    var photo: String { return photo100 }
}
