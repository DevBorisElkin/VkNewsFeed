//
//  String + Height.swift
//  VkNewsFeed
//
//  Created by test on 31.07.2022.
//

import UIKit
import Foundation

extension String {
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(
            with: textSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font : font],
            context: nil
        )
        
        return ceil(size.height) 
    }
}
