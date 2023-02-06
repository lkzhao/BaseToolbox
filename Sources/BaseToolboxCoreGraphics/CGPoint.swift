import CoreGraphics
import BaseToolboxFoundation

extension CGPoint {
    public var transposed: CGPoint {
        CGPoint(x: y, y: x)
    }
    
    public func translate(_ dx: CGFloat, dy: CGFloat) -> CGPoint {
        CGPoint(x: x + dx, y: y + dy)
    }
    
    public func transform(_ trans: CGAffineTransform) -> CGPoint {
        applying(trans)
    }
    
    public func distance(_ point: CGPoint) -> CGFloat {
        sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }
    
    public func midPoint(from: CGPoint) -> CGPoint {
        CGPoint(x: (x + from.x) / 2, y: (y + from.y) / 2)
    }
    
    public func clamp(to rect: CGRect) -> CGPoint {
        CGPoint(x: x.clamp(rect.minX, rect.maxX), y: y.clamp(rect.minY, rect.maxY))
    }

    public func rounded(scale: CGFloat, rule: FloatingPointRoundingRule) -> Self {
        (self * scale).rounded(rule) / scale
    }

    public func rounded(_ rule: FloatingPointRoundingRule) -> Self {
        CGPoint(x: x.rounded(rule), y: y.rounded(rule))
    }
    
    public init(_ cgSize: CGSize) {
        self.init(x: cgSize.width, y: cgSize.height)
    }
    
    // MARK: - CGPoint operations

    public static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        CGPoint(x: left.x + right.x, y: left.y + right.y)
    }

    public static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        CGPoint(x: left.x - right.x, y: left.y - right.y)
    }

    public static func * (left: CGPoint, right: CGPoint) -> CGPoint {
        CGPoint(x: left.x * right.x, y: left.y * right.y)
    }

    public static func / (left: CGPoint, right: CGPoint) -> CGPoint {
        CGPoint(x: left.x / right.x, y: left.y / right.y)
    }

    public static prefix func - (point: CGPoint) -> CGPoint {
        CGPoint.zero - point
    }

    public static func += (left: inout CGPoint, right: CGPoint) {
        left.x += right.x
        left.y += right.y
    }

    public static func -= (left: inout CGPoint, right: CGPoint) {
        left.x -= right.x
        left.y -= right.y
    }
    
    // MARK: - CGPoint CGFloat operations

    public static func + (left: CGPoint, right: CGFloat) -> CGPoint {
        CGPoint(x: left.x + right, y: left.y + right)
    }

    public static func - (left: CGPoint, right: CGFloat) -> CGPoint {
        CGPoint(x: left.x - right, y: left.y - right)
    }

    public static func * (left: CGPoint, right: CGFloat) -> CGPoint {
        CGPoint(x: left.x * right, y: left.y * right)
    }

    public static func / (left: CGPoint, right: CGFloat) -> CGPoint {
        CGPoint(x: left.x / right, y: left.y / right)
    }
    
    // MARK: - CGPoint CGSize operations

    public static func + (left: CGPoint, right: CGSize) -> CGPoint {
        left + CGPoint(right)
    }

    public static func - (left: CGPoint, right: CGSize) -> CGPoint {
        left - CGPoint(right)
    }

    public static func * (left: CGPoint, right: CGSize) -> CGPoint {
        left * CGPoint(right)
    }

    public static func / (left: CGPoint, right: CGSize) -> CGPoint {
        left / CGPoint(right)
    }
}

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

public func abs(_ left: CGPoint) -> CGPoint {
    CGPoint(x: abs(left.x), y: abs(left.y))
}

public func min(_ left: CGPoint, _ right: CGPoint) -> CGPoint {
    CGPoint(x: min(left.x, right.x), y: min(left.y, right.y))
}
