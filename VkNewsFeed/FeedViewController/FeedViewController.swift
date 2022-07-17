//
//  FeedViewController.swift
//  VkNewsFeed
//
//  Created by test on 16.07.2022.
//

import Foundation
import UIKit

class FeedViewController: UIViewController{
    
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        networkService.getFeed()
    }
}
