import CoreGraphics

extension CGRect {
  public var center: CGPoint {
    CGPoint(x: midX, y: midY)
  }
  
  public var bounds: CGRect {
    CGRect(origin: .zero, size: size)
  }
  
  public var transposed: CGRect {
    CGRect(origin: origin.transposed, size: size.transposed)
  }

  /// force positive width and height
  /// (0, 0, -100, -100) -> (-100, -100, 100, 100)
  public var normalized: CGRect {
    return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
  }
  
  public var topLeft: CGPoint {
    CGPoint(x: minX, y: minY)
  }
  
  public var topRight: CGPoint {
    CGPoint(x: maxX, y: minY)
  }
  
  public var bottomLeft: CGPoint {
    CGPoint(x: minX, y: maxY)
  }
  
  public var bottomRight: CGPoint {
    CGPoint(x: maxX, y: maxY)
  }
  
  public init(center: CGPoint, size: CGSize) {
    self.init(origin: center - size / 2, size: size)
  }

  public func rounded(_ scale: CGFloat = 1) -> CGRect {
    CGRect(origin: origin.rounded(scale), size: size.rounded(scale))
  }
}

extension CGRect: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(origin)
    hasher.combine(size)
  }
}

// MARK: - CGRect CGFloat operations

public func + (left: CGRect, right: CGFloat) -> CGRect {
  CGRect(origin: left.origin + right, size: left.size + right)
}

public func - (left: CGRect, right: CGFloat) -> CGRect {
  CGRect(origin: left.origin - right, size: left.size - right)
}

public func * (left: CGRect, right: CGFloat) -> CGRect {
  CGRect(origin: left.origin * right, size: left.size * right)
}

public func / (left: CGRect, right: CGFloat) -> CGRect {
  CGRect(origin: left.origin / right, size: left.size / right)
}

// MARK: - CGRect CGPoint operations

public func + (left: CGRect, right: CGPoint) -> CGRect {
  CGRect(origin: left.origin + right, size: left.size)
}

public func - (left: CGRect, right: CGPoint) -> CGRect {
  CGRect(origin: left.origin - right, size: left.size)
}

// MARK: - CGRect CGSize operations

public func + (left: CGRect, right: CGSize) -> CGRect {
  CGRect(origin: left.origin, size: left.size + right)
}

public func - (left: CGRect, right: CGSize) -> CGRect {
  CGRect(origin: left.origin, size: left.size + right)
}
