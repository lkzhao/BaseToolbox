import UIKit

extension CGPoint {
  var roundedToPixelBoundary: CGPoint {
    rounded(UIScreen.main.scale)
  }
}
