//
//  File.swift
//  
//
//  Created by Luke Zhao on 2/4/23.
//

import Foundation

extension FloatingPoint {
    public func rounded(scale: Self, rule: FloatingPointRoundingRule) -> Self {
        (self * scale).rounded(rule) / scale
    }
}

extension CGFloat {
    // MARK: - CGFloat CGPoint operations
    
    public static func + (left: CGFloat, right: CGPoint) -> CGPoint {
        CGPoint(x: left + right.x, y: left + right.y)
    }

    public static func - (left: CGFloat, right: CGPoint) -> CGPoint {
        CGPoint(x: left - right.x, y: left - right.y)
    }

    public static func * (left: CGFloat, right: CGPoint) -> CGPoint {
        CGPoint(x: left * right.x, y: left * right.y)
    }

    public static func / (left: CGFloat, right: CGPoint) -> CGPoint {
        CGPoint(x: left / right.x, y: left / right.y)
    }
    
    // MARK: - CGFloat CGSize operations
    
    public static func + (left: CGFloat, right: CGSize) -> CGSize {
        CGSize(width: left + right.height, height: left + right.height)
    }

    public static func - (left: CGFloat, right: CGSize) -> CGSize {
        CGSize(width: left - right.height, height: left - right.height)
    }

    public static func * (left: CGFloat, right: CGSize) -> CGSize {
        CGSize(width: left * right.height, height: left * right.height)
    }

    public static func / (left: CGFloat, right: CGSize) -> CGSize {
        CGSize(width: left / right.height, height: left / right.height)
    }
}
