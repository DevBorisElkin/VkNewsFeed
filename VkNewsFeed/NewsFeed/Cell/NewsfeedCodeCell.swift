//
//  NewsfeedCodeCell.swift
//  VkNewsFeed
//
//  Created by test on 31.07.2022.
//

import UIKit
import Foundation

protocol NewsfeedCodeCellDelegate: AnyObject {
    func revealPost(for cell: NewsfeedCodeCell)
}

final class NewsfeedCodeCell : UITableViewCell {
    
    static let reuseId = "NewsfeedCodeCell"
    
    weak var delegate: NewsfeedCodeCellDelegate?
    
    // first layer
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        return view
    }()
    
    // second layer
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .red
        return view
    }()
    
//    let postLabel: UILabel = {
//        let label = UILabel()
//        //label.translatesAutoresizingMaskIntoConstraints = false
//        label.numberOfLines = 0
//        label.font = Constants.postLabelFont
//        //label.backgroundColor = .darkGray
//        label.textColor = .black
//        return label
//    }()
    
    let postLabel: UITextView = {
        let textView = UITextView()
        textView.font = Constants.postLabelFont
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets.init(top: 0, left: -padding, bottom: 0, right: -padding)
        
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        return textView
    }()
    
    let moreTextButton: UIButton = {
        let button = UIButton()
        var textColor = #colorLiteral(red: 0.2439888418, green: 0.4641402364, blue: 0.655207932, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(textColor, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Show full text", for: .normal)
        return button
    }()
    
    let galleryCollectionView = GalleryCollectionView()
    
    let postImageView: WebImageView = {
        let view = WebImageView()
        //view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .gray
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        //view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .orange
        return view
    }()
    
    // third layer for TopView
    
    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //imageView.backgroundColor = .cyan
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.230227977, green: 0.3829107285, blue: 0.920462966, alpha: 1)
        //label.backgroundColor = .green
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        //label.backgroundColor = .red
        return label
    }()
    
    // third layer for bottom view
    
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .red
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .orange
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .green
        return view
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .gray
        return view
    }()
    
    // fourth layer for bottom view individual elements
    
    let likesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()
    
    let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()
    
    let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        return imageView
    }()
    
    // labels
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
        //super.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 1, alpha: 1)
        backgroundColor = .clear
        
        iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
        iconImageView.clipsToBounds = true
        
        overlayFirstLayer() // first layer
        overlaySecondLayer() // second layer
        overlayThirdLayerOnTopView() // third layer for top layer
        overlayThirdLayerOnBottomView() // third layer for bottom view
        overlayForthLayerOnBottomView() // forth layer on bottom individual views
        
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside)
    }
    
    @objc func moreTextButtonTouch(){
        print("Pressed expand text button")
        delegate?.revealPost(for: self)
    }
    
    func overlayFirstLayer(){
        addSubview(cardView)
        
        // card view constraints
        cardView.fillSuperview(padding: Constants.cardInsets)
    }
    
    func overlaySecondLayer(){
        cardView.addSubview(topView)
        //cardView.addSubview(postLabel)
        contentView.addSubview(postLabel)
        contentView.addSubview(moreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(bottomView)
        //cardView.addSubview(galleryCollectionView)
        contentView.addSubview(galleryCollectionView)
        
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
        // moreTextButton.constraints
        // galleryCollectionView constraints
    }
    
    func overlayThirdLayerOnTopView(){
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        // icon image view constraints
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        // name label constraints
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2).isActive = true
        
        // date label constraints
        dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -2).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    func overlayThirdLayerOnBottomView(){
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        // likes view constraints
        likesView.anchor(top: bottomView.topAnchor, leading: bottomView.leadingAnchor, bottom: nil, trailing: nil, size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        commentsView.anchor(top: bottomView.topAnchor, leading: likesView.trailingAnchor, bottom: nil, trailing: nil, size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        sharesView.anchor(top: bottomView.topAnchor, leading: commentsView.trailingAnchor, bottom: nil, trailing: nil, size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        viewsView.anchor(top: bottomView.topAnchor, leading: nil, bottom: nil, trailing: bottomView.trailingAnchor, size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
    }
    
    func overlayForthLayerOnBottomView(){
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        
        helpInForLayer(view: likesView, imageView: likesImage, label: likesLabel)
        helpInForLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
        helpInForLayer(view: sharesView, imageView: sharesImage, label: sharesLabel)
        helpInForLayer(view: viewsView, imageView: viewsImage, label: viewsLabel)
    }
    
    private func helpInForLayer(view: UIView, imageView: UIImageView, label: UILabel){
        // image view constraints
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        
        // label view constraints
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
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
        
        postLabel.frame = viewModel.sizes.postLabelFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        
        if let photoAttachement = viewModel.photoAttachements.first, viewModel.photoAttachements.count == 1 {
            postImageView.set(imageURL: photoAttachement.photoUrlString)
            postImageView.isHidden = false
            galleryCollectionView.isHidden = true
            
            postImageView.frame = viewModel.sizes.attachementFrame
        }else if viewModel.photoAttachements.count > 1 {
            galleryCollectionView.frame = viewModel.sizes.attachementFrame
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.set(photos: viewModel.photoAttachements)
        }
        else{
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
