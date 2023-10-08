import UIKit

extension CGSize {
    public var transposed: CGSize {
        CGSize(width: height, height: width)
    }
    
    public func transform(_ trans: CGAffineTransform) -> CGSize {
        applying(trans)
    }
    
    public func size(fill: CGSize) -> CGSize {
        self * max(fill.width / width, fill.height / height)
    }
    
    public func size(fillIfSmaller fill: CGSize) -> CGSize {
        self * max(1, max(fill.width / width, fill.height / height))
    }
    
    public func size(fit: CGSize) -> CGSize {
        self * min(fit.width / width, fit.height / height)
    }
    
    public func size(fitIfBigger fit: CGSize) -> CGSize {
        self * min(1, min(fit.width / width, fit.height / height))
    }
    
    public func rounded(scale: CGFloat, rule: FloatingPointRoundingRule) -> CGSize {
        (self * scale).rounded(rule) / scale
    }

    public func rounded(_ rule: FloatingPointRoundingRule) -> Self {
        CGSize(width: width.rounded(rule), height: height.rounded(rule))
    }
    
    public init(_ cgPoint: CGPoint) {
        self.init(width: cgPoint.x, height: cgPoint.y)
    }
    
    // MARK: - CGSize operations

    public static func + (left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: left.width + right.width, height: left.height + right.height)
    }

    public static func - (left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: left.width - right.width, height: left.height - right.height)
    }

    public static func * (left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: left.width * right.width, height: left.height * right.height)
    }

    public static func / (left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: left.width / right.width, height: left.height / right.height)
    }

    public static prefix func - (size: CGSize) -> CGSize {
        CGSize.zero - size
    }

    public static func += (left: inout CGSize, right: CGSize) {
        left.width += right.width
        left.height += right.height
    }

    // MARK: - CGSize CGFloat operations

    public static func + (left: CGSize, right: CGFloat) -> CGSize {
        CGSize(width: left.width + right, height: left.height + right)
    }

    public static func - (left: CGSize, right: CGFloat) -> CGSize {
        CGSize(width: left.width - right, height: left.height - right)
    }

    public static func * (left: CGSize, right: CGFloat) -> CGSize {
        CGSize(width: left.width * right, height: left.height * right)
    }

    public static func / (left: CGSize, right: CGFloat) -> CGSize {
        CGSize(width: left.width / right, height: left.height / right)
    }

    // MARK: - CGSize CGPoint operations

    public static func + (left: CGSize, right: CGPoint) -> CGSize {
        left + CGSize(right)
    }

    public static func - (left: CGSize, right: CGPoint) -> CGSize {
        left - CGSize(right)
    }

    public static func * (left: CGSize, right: CGPoint) -> CGSize {
        left * CGSize(right)
    }

    public static func / (left: CGSize, right: CGPoint) -> CGSize {
        left / CGSize(right)
    }
}

extension CGSize: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(width)
        hasher.combine(height)
    }
}

extension CGSize {
    public func inset(by insets: UIEdgeInsets) -> CGSize {
        CGSize(width: width - insets.left - insets.right, height: height - insets.top - insets.bottom)
    }
}

public func abs(_ left: CGSize) -> CGSize {
    CGSize(width: abs(left.width), height: abs(left.height))
}

public func min(_ left: CGSize, _ right: CGSize) -> CGSize {
    CGSize(width: min(left.width, right.width), height: min(left.height, right.height))
}
