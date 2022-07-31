//
//  WebImageView.swift
//  VkNewsFeed
//
//  Created by test on 29.07.2022.
//

import Foundation
import UIKit

class WebImageView: UIImageView {
    
    func set(imageURL: String?){
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.image = nil
            //print("couldn't convert url string to URL")
            return }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)){
            self.image = UIImage(data: cachedResponse.data)
            //print("load image from cache")
            return
        }
        
        //print("load image from internet")
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse){
        guard let responseUrl = response.url else{ return }
        
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseUrl))
    }
}
