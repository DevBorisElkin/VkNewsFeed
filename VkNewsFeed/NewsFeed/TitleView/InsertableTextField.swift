//
//  InsertableTextField.swift
//  VkNewsFeed
//
//  Created by test on 03.08.2022.
//

import Foundation
import UIKit

class InsertableTextField: UITextField{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .brown
        placeholder = "Search"
        font = UIFont.systemFont(ofSize: 14, weight: .medium)
        clearButtonMode = .whileEditing
        borderStyle = .none
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        let image = UIImage(named: "search2")
        leftView = UIImageView(image: image)
        leftView?.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error with coder")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }
}
