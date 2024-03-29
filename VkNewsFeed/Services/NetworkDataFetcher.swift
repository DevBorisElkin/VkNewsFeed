//
//  NetworkDataFetcher.swift
//  VkNewsFeed
//
//  Created by test on 22.07.2022.
//

import Foundation

protocol DataFetcher{
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void)
    func getUser(response: @escaping (UserResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher{
    
    private let authService: AuthService
    let networking: Networking
    
    init(networking: Networking, authService: AuthService = SceneDelegate.shared().authService){
        self.networking = networking
        self.authService = authService
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = authService.userId else { return }
        let params = ["user_ids" : userId, "fields" : "photo_100"]
        networking.request(path: API.user, params: params) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }
    }
    
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void) {
        var params = ["filters" : "post, photo"]
        params["start_from"] = nextBatchFrom
        networking.request(path: API.newsfeed, params: params) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        
        // If you need to see JSON file
//        if let data = from, var json = try? JSONSerialization.jsonObject(with: data, options: []){
//            print("-----JSON Retrieved-----\n\(json)\n-----JSON Ended-----")
//        }else{
//            print("Couldn't get JSON")
//        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
}
