import CoreGraphics

extension CGAffineTransform {
  public func translatedBy(x: CGFloat) -> CGAffineTransform {
    translatedBy(x: x, y: 0)
  }
  
  public func translatedBy(y: CGFloat) -> CGAffineTransform {
    translatedBy(x: 0, y: y)
  }
  
  public func translatedBy(_ point: CGPoint) -> CGAffineTransform {
    translatedBy(x: point.x, y: point.y)
  }

  public func scaledBy(x: CGFloat) -> CGAffineTransform {
    scaledBy(x: x, y: 1)
  }
  
  public func scaledBy(y: CGFloat) -> CGAffineTransform {
    scaledBy(x: 1, y: y)
  }
  
  public func scaledBy(_ scale: CGFloat) -> CGAffineTransform {
    scaledBy(x: scale, y: scale)
  }
  
  public func scaledBy(_ scale: CGSize) -> CGAffineTransform {
    scaledBy(x: scale.width, y: scale.height)
  }
}

extension CGAffineTransform {
  public mutating func translateBy(x: CGFloat = 0, y: CGFloat = 0) {
    self = translatedBy(x: x, y: y)
  }
  
  public mutating func translateBy(_ point: CGPoint) {
    self = translatedBy(point)
  }

  public mutating func scaleBy(x: CGFloat = 1, y: CGFloat = 1) {
    self = scaledBy(x: x, y: y)
  }
  
  public mutating func scaleBy(_ scale: CGFloat) {
    self = scaledBy(scale)
  }
  
  public mutating func scaleBy(_ scale: CGSize) {
    self = scaledBy(scale)
  }
  
  public mutating func rotateBy(_ angle: CGFloat) {
    self = rotated(by: angle)
  }

  public mutating func invert() {
    self = inverted()
  }

  public mutating func concatenate(_ t2: CGAffineTransform) {
    self = concatenating(t2)
  }
}
