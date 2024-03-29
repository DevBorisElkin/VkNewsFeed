//
//  Constants.swift
//  VkNewsFeed
//
//  Created by test on 02.08.2022.
//

import Foundation
import UIKit

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 43
    static let postLabelInsets = UIEdgeInsets(top: 5 + Constants.topViewHeight + 10, left: 8 + cardViewXOffset, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 45
    
    static let bottomViewViewHeight: CGFloat = 44
    static let bottomViewViewWidth: CGFloat = 80
    
    static let bottomViewViewsIconSize: CGFloat = 24
    
    static let minifiedPostLimitLines: CGFloat = 8
    static let minifiedPostLines: CGFloat = 6
    
    static let moreTextButtonSize: CGSize = CGSize(width: 170, height: 30)
    static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    
    static let cardViewXOffset: CGFloat = 8
}
