import QuartzCore

extension CATransform3D: Equatable {
  public static func == (lhs: CATransform3D, rhs: CATransform3D) -> Bool {
    CATransform3DEqualToTransform(lhs, rhs)
  }
}
