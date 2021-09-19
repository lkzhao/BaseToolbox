import UIKit

extension CGPoint {
  public var roundedToPixelBoundary: CGPoint {
    rounded(UIScreen.main.scale)
  }
}
