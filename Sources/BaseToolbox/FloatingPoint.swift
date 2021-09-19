import Foundation

extension FloatingPoint {
  public func clamp(_ minValue: Self, _ maxValue: Self) -> Self {
    self < minValue ? minValue : (self > maxValue ? maxValue : self)
  }
}
