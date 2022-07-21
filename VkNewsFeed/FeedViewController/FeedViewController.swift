//
//  FeedViewController.swift
//  VkNewsFeed
//
//  Created by test on 16.07.2022.
//

import Foundation
import UIKit

class FeedViewController: UIViewController{
    
    private let networkService: Networking = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        let params = ["filters" : "post, photo"]
        networkService.request(path: API.newsfeed, params: params) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Something is wrong with data")
                return
            }
            
            var json = try? JSONSerialization.jsonObject(with: data, options: [])
            print("json: \(json!)")
        }
    }
}
