import UIKit

extension CGRect {
    public var roundedToPixelBoundary: CGRect {
        CGRect(origin: origin.roundedToPixelBoundary, size: size.roundedToPixelBoundary)
    }
    
    public func closestCorner(point: CGPoint) -> UIRectCorner {
        let corners: [(point: CGPoint, corner: UIRectCorner)] = [
            (topLeft, .topLeft),
            (topRight, .topRight),
            (bottomLeft, .bottomLeft),
            (bottomRight, .bottomRight),
        ]
        return corners.sorted { a, b in
            point.distance(a.point) < point.distance(b.point)
        }.first!.corner
    }
    
    public mutating func offset(corner: UIRectCorner, offset: CGPoint, minimumSize: CGSize, maximumSize: CGSize) {
        switch corner {
        case .topLeft:
            let clamped = CGPoint(x: offset.x.clamp(-origin.x, size.width - minimumSize.width),
                                  y: offset.y.clamp(-origin.y, size.height - minimumSize.height))
            origin = CGPoint(x: origin.x + clamped.x, y: origin.y + clamped.y)
            size = CGSize(width: size.width - clamped.x, height: size.height - clamped.y)
        case .topRight:
            let clamped = CGPoint(x: offset.x.clamp(-(size.width - minimumSize.width), maximumSize.width - origin.x - size.width),
                                  y: offset.y.clamp(-origin.y, size.height - minimumSize.height))
            origin = CGPoint(x: origin.x, y: origin.y + clamped.y)
            size = CGSize(width: size.width + clamped.x, height: size.height - clamped.y)
        case .bottomLeft:
            let clamped = CGPoint(x: offset.x.clamp(-origin.x, size.width - minimumSize.width),
                                  y: offset.y.clamp(-(size.height - minimumSize.height), maximumSize.height - origin.y - size.height))
            origin = CGPoint(x: origin.x + clamped.x, y: origin.y)
            size = CGSize(width: size.width - clamped.x, height: size.height + clamped.y)
        case .bottomRight:
            let clamped = CGPoint(x: offset.x.clamp(-(size.width - minimumSize.width), maximumSize.width - origin.x - size.width),
                                  y: offset.y.clamp(-(size.height - minimumSize.height), maximumSize.height - origin.y - size.height))
            origin = CGPoint(x: origin.x, y: origin.y)
            size = CGSize(width: size.width + clamped.x, height: size.height + clamped.y)
        default:
            break
        }
    }
}
