//
//  Constants.swift
//  Experiment
//
//  Created by Michael NLNZ on 16/02/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class Settings {
    static let homePath = "/Users/nlnz/Desktop/PresentationImages"
    static let musicBeat = 2.9203
    static let musicStartDelay = 0.1
}


// EXTENSIONS


extension NSBezierPath {
    
    var cgPath: CGPath {
        get { return self.transformToCGPath() }
    }
    
    /// Transforms the NSBezierPath into a CGPath
    ///
    /// :returns: The transformed NSBezierPath
    private func transformToCGPath() -> CGPath {
        
        // Create path
        var path = CGMutablePath()
        var points = UnsafeMutablePointer<NSPoint>.allocate(capacity: 3)
        let numElements = self.elementCount
        
        if numElements > 0 {
            
            var didClosePath = true
            
            for index in 0..<numElements {
                
                let pathType = self.element(at: index, associatedPoints: points)
                
                switch pathType {
                    
                case .moveToBezierPathElement:
                    path.move(to: CGPoint(x: points[0].x, y: points[0].y))
                case .lineToBezierPathElement:
                    path.addLine(to: CGPoint(x: points[0].x, y: points[0].y))
                    didClosePath = false
                case .curveToBezierPathElement:
                    path.addCurve(to: CGPoint(x: points[0].x, y: points[0].y), control1: CGPoint(x: points[1].x, y: points[1].y), control2: CGPoint(x: points[2].x, y: points[2].y))
                    didClosePath = false
                case .closePathBezierPathElement:
                    path.closeSubpath()
                    didClosePath = true
                }
            }
            
            if !didClosePath { path.closeSubpath() }
        }
        return path
    }
}
