import UIKit

extension CGSize {
  var roundedToPixelBoundary: CGSize {
    rounded(UIScreen.main.scale)
  }

  public func inset(by insets: UIEdgeInsets) -> CGSize {
    CGSize(width: width - insets.left - insets.right, height: height - insets.top - insets.bottom)
  }
}
