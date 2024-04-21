//
//  RoundedProgressView.swift
//  NeuroNavigate
//
//  Created by yahia salman on 4/20/24.
//

//import UIKit
//
//class RoundedProgressView: UIProgressView {
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: 15)
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = bounds
//        maskLayer.path = maskLayerPath.cgPath
//        layer.mask = maskLayer
//
//        guard let progressLayer = layer.sublayers?[1] else { return }
//        progressLayer.cornerRadius = 15
//        progressLayer.masksToBounds = true
//
//        // Ensuring the track also has rounded corners if it wasn't clear
//        if let trackLayer = layer.sublayers?.first {
//            trackLayer.cornerRadius = 15
//            trackLayer.masksToBounds = true
//        }
//    }
//}

import UIKit

class RoundedProgressView: UIProgressView {

    override func layoutSubviews() {
        super.layoutSubviews()

        // Apply a mask to the entire progress view to round corners
        layer.cornerRadius = 15
        layer.masksToBounds = true
        layer.sublayers?[safe: 1]?.cornerRadius = 15  // Applies the corner radius to the progress layer
        layer.sublayers?[safe: 1]?.masksToBounds = true

        // Apply a mask to the track layer separately
        layer.sublayers?.first?.cornerRadius = 15
        layer.sublayers?.first?.masksToBounds = true

        // Ensure the progress view itself has rounded corners
        clipsToBounds = true
    }
}

extension Collection {
    /// Safely access elements within the collection.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
