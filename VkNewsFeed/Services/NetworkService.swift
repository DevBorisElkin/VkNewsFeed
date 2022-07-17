//
//  NetworkService.swift
//  VkNewsFeed
//
//  Created by test on 17.07.2022.
//

import Foundation

final class NetworkService{
    
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService){
        self.authService = authService
    }
    
    func getFeed(){
        guard let token = authService.token else{ return }
        
        // https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.131
        let params = ["filters" : "post,photo"]
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = "\(API.version)"
        
        
        
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsfeed
        components.queryItems = allParams.map{ URLQueryItem(name: $0, value: $1) }
        
        let url = components.url!
        print(url)
    }
}
