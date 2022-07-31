//
//  NewsfeedCodeCell.swift
//  VkNewsFeed
//
//  Created by test on 31.07.2022.
//

import UIKit
import Foundation

final class NewsfeedCodeCell : UITableViewCell {
    
    static let reuseId = "NewsfeedCodeCell"
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(cardView)
        
        backgroundColor = .red
        
        // cardView constraints
        //cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        cardView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true // to add offset to anhor 12
//        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
//        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
//        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
        //cardView.fillSuperview()
        
        cardView.fillSuperview(padding: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
        
//        cardView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
//        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
//        cardView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        cardView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
//        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
//        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
//        cardView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        cardView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
//        cardView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        cardView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        cardView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
