//
//  File.swift
//  BaseToolbox
//
//  Created by Luke Zhao on 3/2/26.
//

import Foundation
import simd
import QuartzCore
import UIKit

public protocol SIMDValue {
    associatedtype SIMDType: SIMD
    @inlinable var simd: SIMDType { get }
    @inlinable static func fromSIMD(_ simd: SIMDType) -> Self
}

@inlinable public func lerp<V: SIMD>(from start: V, to end: V, progress: V.Scalar) -> V where V.Scalar: FloatingPoint {
    start + (end - start) * progress
}

@inlinable public func lerp<V: SIMDValue>(from start: V, to end: V, progress: V.SIMDType.Scalar) -> V where V.SIMDType.Scalar: FloatingPoint {
    V.fromSIMD(lerp(from: start.simd, to: end.simd, progress: progress))
}

@inlinable @inline(__always) public func smoothStep<V: SIMD>(from start: V, to end: V, progress: V.Scalar) -> V where V.Scalar == Double {
    lerp(from: start, to: end, progress: smoothStep(from: 0, to: 1, progress: progress))
}

@inlinable @inline(__always) public func smoothStep<V: SIMD>(from start: V, to end: V, progress: V.Scalar) -> V where V.Scalar == Float {
    lerp(from: start, to: end, progress: smoothStep(from: 0, to: 1, progress: progress))
}

@inlinable @inline(__always) public func smoothStep<V: SIMDValue>(from start: V, to end: V, progress: V.SIMDType.Scalar) -> V where V.SIMDType.Scalar == Double {
    V.fromSIMD(smoothStep(from: start.simd, to: end.simd, progress: progress))
}

@inlinable @inline(__always) public func smoothStep<V: SIMDValue>(from start: V, to end: V, progress: V.SIMDType.Scalar) -> V where V.SIMDType.Scalar == Float {
    V.fromSIMD(smoothStep(from: start.simd, to: end.simd, progress: progress))
}

extension CGPoint: SIMDValue {
    @inlinable public var simd: SIMD2<CGFloat.NativeType> {
        SIMD2(x, y)
    }

    @inlinable public static func fromSIMD(_ simd: SIMD2<CGFloat.NativeType>) -> CGPoint {
        CGPoint(x: simd[0], y: simd[1])
    }
}

extension CGSize: SIMDValue {
    @inlinable public var simd: SIMD2<CGFloat.NativeType> {
        SIMD2(width, height)
    }

    @inlinable public static func fromSIMD(_ simd: SIMD2<CGFloat.NativeType>) -> CGSize {
        CGSize(width: simd[0], height: simd[1])
    }
}

extension CGRect: SIMDValue {
    @inlinable public var simd: SIMD4<CGFloat.NativeType> {
        SIMD4(origin.x, origin.y, size.width, size.height)
    }

    @inlinable public static func fromSIMD(_ simd: SIMD4<CGFloat.NativeType>) -> CGRect {
        CGRect(
            origin: CGPoint(x: simd[0], y: simd[1]),
            size: CGSize(width: simd[2], height: simd[3])
        )
    }
}

extension UIColor: SIMDValue {
    @inlinable public var simd: SIMD4<CGFloat.NativeType> {
        let (r, g, b, a) = rgba
        return SIMD4(r, g, b, a)
    }

    @inlinable public static func fromSIMD(_ simd: SIMD4<CGFloat.NativeType>) -> Self {
        Self(
            red: simd[0],
            green: simd[1],
            blue: simd[2],
            alpha: simd[3]
        )
    }
}

extension CGAffineTransform: SIMDValue {
    @inlinable public var simd: SIMD8<CGFloat.NativeType> {
        SIMD8(a, b, c, d, tx, ty, 0, 1)
    }

    @inlinable public static func fromSIMD(_ simd: SIMD8<CGFloat.NativeType>) -> CGAffineTransform {
        CGAffineTransform(
            a: simd[0], b: simd[1],
            c: simd[2], d: simd[3],
            tx: simd[4], ty: simd[5]
        )
    }
}

extension CATransform3D: SIMDValue {
    @inlinable public var simd: SIMD16<CGFloat.NativeType> {
        SIMD16(
            m11, m12, m13, m14,
            m21, m22, m23, m24,
            m31, m32, m33, m34,
            m41, m42, m43, m44
        )
    }

    @inlinable public static func fromSIMD(_ simd: SIMD16<CGFloat.NativeType>) -> CATransform3D {
        CATransform3D(
            m11: simd[0], m12: simd[1], m13: simd[2], m14: simd[3],
            m21: simd[4], m22: simd[5], m23: simd[6], m24: simd[7],
            m31: simd[8], m32: simd[9], m33: simd[10], m34: simd[11],
            m41: simd[12], m42: simd[13], m43: simd[14], m44: simd[15]
        )
    }
}
