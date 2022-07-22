//
//  FeedViewController.swift
//  VkNewsFeed
//
//  Created by test on 16.07.2022.
//

import Foundation
import UIKit

class FeedViewController: UIViewController{
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        fetcher.getFeed { feedResponse in
            guard let feedResponse = feedResponse else { return }
            
            feedResponse.items.map { feedItem in
                print(feedItem.date)
            }
        }
    }
}

//            response?.response.items.map({ feedItem in
//                print(feedItem.text)
//            })
            
//            var json = try? JSONSerialization.jsonObject(with: data, options: [])
//            print("json: \(json!)")
