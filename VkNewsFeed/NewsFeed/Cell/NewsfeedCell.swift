//
//  NewsfeedCell.swift
//  VkNewsFeed
//
//  Created by test on 28.07.2022.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get set }
    var name: String { get set }
    var date: String { get set }
    var text: String? { get set }
    var likes: String? { get set }
    var comments: String { get set }
    var shares: String { get set }
    var views: String { get set }
    
    var sizes: FeedCellSizes { get }
    var photoAttachement: FeedCellPhotoAttachmentViewModel? { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachementFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

class NewsfeedCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCell"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
        //super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let iconImageView = iconImageView{
            iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
            iconImageView.clipsToBounds = true
        }
        
        if let cardView = cardView {
            cardView.layer.cornerRadius = 10
            cardView.clipsToBounds = true
        }
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func set(viewModel: FeedCellViewModel){
        iconImageView.set(imageURL: viewModel.iconUrlString)
        
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        // TODO fix sizes for elements
        postLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachementFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        
        if let photoAttachement = viewModel.photoAttachement{
            postImageView.set(imageURL: photoAttachement.photoUrlString)
            postImageView.isHidden = false
        }else{
            postImageView.isHidden = true
        }
    }
}
