//
//  File.swift
//  
//
//  Created by Luke Zhao on 2/4/23.
//

import Foundation
import simd

extension FloatingPoint {
    public func rounded(scale: Self, rule: FloatingPointRoundingRule) -> Self {
        (self * scale).rounded(rule) / scale
    }
}

@inlinable public func lerp<T: FloatingPoint>(from start: T, to end: T, progress: T) -> T {
    start + (end - start) * progress
}

@inlinable @inline(__always) public func smoothStep(from start: Double, to end: Double, progress: Double) -> Double {
    simd_smoothstep(start, end, progress)
}

@inlinable @inline(__always) public func smoothStep(from start: Float, to end: Float, progress: Float) -> Float {
    simd_smoothstep(start, end, progress)
}

extension CGFloat {
    // MARK: - CGFloat CGPoint operations
    
    @inlinable public static func + (left: CGFloat, right: CGPoint) -> CGPoint {
        CGPoint(x: left + right.x, y: left + right.y)
    }

    @inlinable public static func - (left: CGFloat, right: CGPoint) -> CGPoint {
        CGPoint(x: left - right.x, y: left - right.y)
    }

    @inlinable public static func * (left: CGFloat, right: CGPoint) -> CGPoint {
        CGPoint(x: left * right.x, y: left * right.y)
    }

    @inlinable public static func / (left: CGFloat, right: CGPoint) -> CGPoint {
        CGPoint(x: left / right.x, y: left / right.y)
    }
    
    // MARK: - CGFloat CGSize operations
    
    @inlinable public static func + (left: CGFloat, right: CGSize) -> CGSize {
        CGSize(width: left + right.width, height: left + right.height)
    }

    @inlinable public static func - (left: CGFloat, right: CGSize) -> CGSize {
        CGSize(width: left - right.width, height: left - right.height)
    }

    @inlinable public static func * (left: CGFloat, right: CGSize) -> CGSize {
        CGSize(width: left * right.width, height: left * right.height)
    }

    @inlinable public static func / (left: CGFloat, right: CGSize) -> CGSize {
        CGSize(width: left / right.width, height: left / right.height)
    }
}
