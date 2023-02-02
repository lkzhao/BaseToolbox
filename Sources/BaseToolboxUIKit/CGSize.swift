import UIKit

extension CGSize {
    public func inset(by insets: UIEdgeInsets) -> CGSize {
        CGSize(width: width - insets.left - insets.right, height: height - insets.top - insets.bottom)
    }
}
