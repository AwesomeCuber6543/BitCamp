//
//  RainbowProgressView.swift
//  NeuroNavigate
//
//  Created by yahia salman on 4/21/24.
//

import UIKit

class RainbowProgressView: UIView {
    // Progress layer to represent the progress bar
    private let progressLayer = CALayer()
    // Gradient layer for rainbow effect
    private let gradientLayer = CAGradientLayer()
    
    // Progress property: 0.0 to 1.0
    var progress: CGFloat = 0.0 {
        didSet {
            updateProgress()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        // Set up the gradient with rainbow colors
        gradientLayer.colors = [
            UIColor.red.cgColor,
            UIColor.orange.cgColor,
            UIColor.yellow.cgColor,
            UIColor.green.cgColor,
            UIColor.blue.cgColor,
            UIColor.systemIndigo.cgColor,
            UIColor.purple.cgColor
        ]
        gradientLayer.locations = [0.0, 0.17, 0.34, 0.51, 0.68, 0.85, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.addSublayer(gradientLayer)
        
        // Initialize progress layer with a solid background that will be masked by gradient
        progressLayer.backgroundColor = UIColor.white.cgColor
        layer.addSublayer(progressLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        updateProgress()
    }
    
    private func updateProgress() {
        // Update progress layer's frame according to current progress
        let progressWidth = bounds.width * progress
        progressLayer.frame = CGRect(x: 0, y: 0, width: progressWidth, height: bounds.height)
        gradientLayer.mask = progressLayer
    }
}

