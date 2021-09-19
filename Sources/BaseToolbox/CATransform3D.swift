import QuartzCore

extension CATransform3D {
  public static let identity = CATransform3DIdentity

  public var isIdentity: Bool {
    CATransform3DIsIdentity(self)
  }

  public var isAffine: Bool {
    CATransform3DIsAffine(self)
  }

  public var affineTransform: CGAffineTransform {
    CATransform3DGetAffineTransform(self)
  }

  init(affineTransform: CGAffineTransform) {
    self = CATransform3DMakeAffineTransform(affineTransform)
  }
}

extension CATransform3D: Equatable {
  public static func == (lhs: CATransform3D, rhs: CATransform3D) -> Bool {
    CATransform3DEqualToTransform(lhs, rhs)
  }
}

extension CATransform3D {
  public func translatedBy(x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CATransform3D {
    CATransform3DTranslate(self, x, y, z)
  }
  
  public func translatedBy(_ point: CGPoint) -> CATransform3D {
    CATransform3DTranslate(self, point.x, point.y, 0)
  }

  public func scaledBy(x: CGFloat = 1, y: CGFloat = 1, z: CGFloat = 1) -> CATransform3D {
    CATransform3DScale(self, x, y, z)
  }
  
  public func scaledBy(_ scale: CGFloat) -> CATransform3D {
    CATransform3DScale(self, scale, scale, 1)
  }
  
  public func scaledBy(_ scale: CGSize) -> CATransform3D {
    CATransform3DScale(self, scale.width, scale.height, 1)
  }

  public func rotatedBy(angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) -> CATransform3D {
    CATransform3DRotate(self, angle, x, y, z)
  }

  public func rotatedBy(x: CGFloat) -> CATransform3D {
    CATransform3DRotate(self, x, 1, 0, 0)
  }

  public func rotatedBy(y: CGFloat) -> CATransform3D {
    CATransform3DRotate(self, y, 0, 1, 0)
  }

  public func rotatedBy(z: CGFloat) -> CATransform3D {
    CATransform3DRotate(self, z, 0, 0, 1)
  }
  
  public func rotatedBy(_ angle: CGFloat) -> CATransform3D {
    CATransform3DRotate(self, angle, 0, 0, 1)
  }

  public func withPerspective(m34: CGFloat) -> CATransform3D {
    var trans = self
    trans.m34 = m34
    return trans
  }

  public func inverted() -> CATransform3D {
    CATransform3DInvert(self)
  }

  public func concatenating(_ t2: CATransform3D) -> CATransform3D {
    CATransform3DConcat(self, t2)
  }
}

extension CATransform3D {
  public mutating func translateBy(x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) {
    self = translatedBy(x: x, y: y, z: z)
  }
  
  public mutating func translateBy(_ point: CGPoint) {
    self = translatedBy(point)
  }

  public mutating func scaleBy(x: CGFloat = 1, y: CGFloat = 1, z: CGFloat = 1) {
    self = scaledBy(x: x, y: y, z: z)
  }
  
  public mutating func scaleBy(_ scale: CGFloat) {
    self = scaledBy(scale)
  }
  
  public mutating func scaleBy(_ scale: CGSize) {
    self = scaledBy(scale)
  }

  public mutating func rotateBy(angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) {
    self = rotatedBy(angle: angle, x: x, y: y, z: z)
  }

  public mutating func rotateBy(x: CGFloat) {
    self = rotatedBy(x: x)
  }

  public mutating func rotateBy(y: CGFloat) {
    self = rotatedBy(y: y)
  }

  public mutating func rotateBy(z: CGFloat) {
    self = rotatedBy(z: z)
  }
  
  public mutating func rotateBy(_ angle: CGFloat) {
    self = rotatedBy(angle)
  }

  public mutating func perspective(m34: CGFloat) {
    self.m34 = m34
  }

  public mutating func invert() {
    self = inverted()
  }

  public mutating func concatenate(_ t2: CATransform3D) {
    self = concatenating(t2)
  }
}
