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

  public func translatedBy(x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CATransform3D {
    CATransform3DTranslate(self, x, y, z)
  }

  public func scaledBy(x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CATransform3D {
    CATransform3DScale(self, x, y, z)
  }

  public func rotated(by angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) -> CATransform3D {
    CATransform3DRotate(self, angle, x, y, z)
  }

  public func rotated(x: CGFloat) -> CATransform3D {
    CATransform3DRotate(self, x, 1, 0, 0)
  }

  public func rotated(y: CGFloat) -> CATransform3D {
    CATransform3DRotate(self, y, 0, 1, 0)
  }

  public func rotated(z: CGFloat) -> CATransform3D {
    CATransform3DRotate(self, z, 0, 0, 1)
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

  init(affineTransform: CGAffineTransform) {
    self = CATransform3DMakeAffineTransform(affineTransform)
  }
}

extension CATransform3D: Equatable {
  public static func == (lhs: CATransform3D, rhs: CATransform3D) -> Bool {
    CATransform3DEqualToTransform(lhs, rhs)
  }
}
