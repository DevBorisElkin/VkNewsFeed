//
//  NewsfeedCellLayoutCalculator.swift
//  VkNewsFeed
//
//  Created by test on 31.07.2022.
//

import UIKit
import Foundation

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachement: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var attachementFrame: CGRect
    
    var bottomView: CGRect
    var totalHeight: CGFloat
}

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 36
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
}

final class NewsfeedCellLayoutCalculator : FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachement: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        // MARK: Working on postLabelFrame
        
        // origin = coordinate
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
        
        if let postText = postText, !postText.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = postText.height(width: width, font: Constants.postLabelFont)
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: Working on attachementFrame
        
        // todo do work with attachement frame
        return Sizes.init(
            postLabelFrame: postLabelFrame,
            attachementFrame: CGRect.zero,
            bottomView: CGRect.zero,
            totalHeight: 300
        )
    }
}
