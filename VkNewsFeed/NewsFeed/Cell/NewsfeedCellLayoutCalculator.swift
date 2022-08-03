//
//  NewsfeedCellLayoutCalculator.swift
//  VkNewsFeed
//
//  Created by test on 31.07.2022.
//

import UIKit
import Foundation

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachement: FeedCellPhotoAttachmentViewModel?, isFullSizedPost: Bool) -> FeedCellSizes
}

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var moreTextButtonFrame: CGRect
    var attachementFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}

final class NewsfeedCellLayoutCalculator : FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachement: FeedCellPhotoAttachmentViewModel?, isFullSizedPost: Bool) -> FeedCellSizes {
        
        var showMoreTextButton = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        // MARK: Working on postLabelFrame
        
        // origin = coordinate
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
        
        if let postText = postText, !postText.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = postText.height(width: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
            
            if !isFullSizedPost && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: sizes and location of ShowMoreText button
        
        var moreTextButtonSize = CGSize.zero
        
        if(showMoreTextButton){
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        // MARK: Working on attachementFrame
        
        let attachementTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        
        var attachementFrame = CGRect(origin: CGPoint(x: 0, y: attachementTop), size: .zero)
        
        if let attachement = photoAttachement {
            let photoHeight: Float = Float(attachement.height)
            let photoWidth: Float = Float(attachement.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            attachementFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio )
        }
        
        // MARK: Working on attachementFrame
        
        let bottomViewTop = max(postLabelFrame.maxY, attachementFrame.maxY)
        
        let bottomViewFrame = CGRect(
            origin: CGPoint(x: 0, y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight)
        )
        
        // MARK: Total Height
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes.init(
            postLabelFrame: postLabelFrame,
            moreTextButtonFrame: moreTextButtonFrame,
            attachementFrame: attachementFrame,
            bottomViewFrame: bottomViewFrame,
            totalHeight: totalHeight
        )
    }
}
