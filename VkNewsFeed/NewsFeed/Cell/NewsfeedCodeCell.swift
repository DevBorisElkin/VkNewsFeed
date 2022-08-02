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
    
    // first layer
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        print("UIView - Created once")
        return view
    }()
    
    // second layer
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        //label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = Constants.postLabelFont
        label.backgroundColor = .darkGray
        label.textColor = .black
        return label
    }()
    
    let postImageView: WebImageView = {
        let view = WebImageView()
        //view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        //view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        overlayFirstLayer() // first layer
        overlaySecondLayer() // second layer
    }
    
    func overlayFirstLayer(){
        addSubview(cardView)
        
        // card view constraints
        cardView.fillSuperview(padding: Constants.cardInsets)
    }
    
    func overlaySecondLayer(){
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(postImageView)
        cardView.addSubview(bottomView)
        
        //topView.constraints
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        //postLabel.constraints
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        //postImageView.constraints
        
        //bottomView.constraints
    }
    
    func set(viewModel: FeedCellViewModel){
        //postLabel.text = viewModel.text
        
        // TODO fix sizes for elements
        postLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachementFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        
        if let photoAttachement = viewModel.photoAttachement{
            //postImageView.set(imageURL: photoAttachement.photoUrlString)
            postImageView.isHidden = false
        }else{
            postImageView.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
