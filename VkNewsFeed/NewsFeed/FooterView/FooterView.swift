//
//  FooterView.swift
//  VkNewsFeed
//
//  Created by test on 04.08.2022.
//

import Foundation
import UIKit

class FooterView: UIView {
    
    private var myLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(myLabel)
        addSubview(loader)
        
        myLabel.anchor(top: topAnchor,
                       leading: leadingAnchor,
                       bottom: nil,
                       trailing: trailingAnchor,
                       padding: UIEdgeInsets(top: 8, left: 20, bottom: 777, right: 20))
        
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    func showLoader(){
        loader.startAnimating()
    }
    
    func setTitle(title: String?){
        loader.stopAnimating()
        myLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
