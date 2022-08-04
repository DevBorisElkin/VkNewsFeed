//
//  GradientView.swift
//  VkNewsFeed
//
//  Created by test on 04.08.2022.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    @IBInspectable private var startColor: UIColor! {
        didSet{
            setUpGradientColors()
        }
    }
    @IBInspectable private var endColor: UIColor! {
        didSet {
            setUpGradientColors()
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    
    // this initializator is called when we create view with code
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpGradient()
    }
    
    // this initializator is called when our view is created in storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
    
    private func setUpGradient(){
        self.layer.addSublayer(gradientLayer)
        setUpGradientColors()
        
        // from 0 to 1
        // set gradiend 'direction', use 0,0  1,1 to set from top-left corner to bottom-right corner
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
    }
    
    private func setUpGradientColors(){
        if let startColor = startColor, let endColor = endColor {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
}
