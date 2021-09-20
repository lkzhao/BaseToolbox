import UIKit
import BaseToolboxCoreGraphics

extension UIView {
  private struct AssociateKey {
    static var borderColor: Void?
    static var shadowColor: Void?
    static var hitTestSlop: Void?
  }
  
  open var cornerRadius: CGFloat {
    get { layer.cornerRadius }
    set { layer.cornerRadius = newValue }
  }
  
  open var zPosition: CGFloat {
    get { layer.zPosition }
    set { layer.zPosition = newValue }
  }

  open var borderWidth: CGFloat {
    get { layer.borderWidth }
    set { layer.borderWidth = newValue }
  }
  
  open var shadowOpacity: CGFloat {
    get { CGFloat(layer.shadowOpacity) }
    set { layer.shadowOpacity = Float(newValue) }
  }
  
  open var shadowRadius: CGFloat {
    get { layer.shadowRadius }
    set { layer.shadowRadius = newValue }
  }
  
  open var shadowOffset: CGSize {
    get { layer.shadowOffset }
    set { layer.shadowOffset = newValue }
  }
  
  open var shadowPath: UIBezierPath? {
    get { layer.shadowPath.map { UIBezierPath(cgPath: $0) } }
    set { layer.shadowPath = newValue?.cgPath }
  }
  
  open var hitTestSlop: UIEdgeInsets {
    get {
      (objc_getAssociatedObject(self, &AssociateKey.hitTestSlop) as? NSValue)?.uiEdgeInsetsValue ?? .zero
    }
    set {
      _ = UIView.swizzlePointInside
      objc_setAssociatedObject(self, &AssociateKey.hitTestSlop, NSValue(uiEdgeInsets: newValue), .OBJC_ASSOCIATION_RETAIN)
    }
  }
  
  open var borderColor: UIColor? {
    get {
      objc_getAssociatedObject(self, &AssociateKey.borderColor) as? UIColor
    }
    set {
      _ = UIView.swizzleTraitCollection
      objc_setAssociatedObject(self, &AssociateKey.borderColor, newValue, .OBJC_ASSOCIATION_RETAIN)
      layer.borderColor = borderColor?.resolvedColor(with: traitCollection).cgColor
    }
  }

  open var shadowColor: UIColor? {
    get {
      objc_getAssociatedObject(self, &AssociateKey.shadowColor) as? UIColor
    }
    set {
      _ = UIView.swizzleTraitCollection
      objc_setAssociatedObject(self, &AssociateKey.shadowColor, newValue, .OBJC_ASSOCIATION_RETAIN)
      layer.shadowColor = shadowColor?.resolvedColor(with: traitCollection).cgColor
    }
  }

  open var frameWithoutTransform: CGRect {
    get {
      CGRect(center: center, size: bounds.size)
    }
    set {
      bounds.size = newValue.size
      center = newValue.offsetBy(
        dx: bounds.width * (layer.anchorPoint.x - 0.5),
        dy: bounds.height * (layer.anchorPoint.y - 0.5)
      ).center
    }
  }
  
  open var firstResponder: UIView? {
    if isFirstResponder {
      return self
    }
    for subview in subviews {
      if let firstResponder = subview.firstResponder {
        return firstResponder
      }
    }
    return nil
  }

  open class var isInAnimationBlock: Bool {
    UIView.perform(NSSelectorFromString("_isInAnimationBlock")) != nil
  }
  
  private static let swizzlePointInside: Void = {
     guard let originalMethod = class_getInstanceMethod(UIView.self, #selector(point(inside:with:))),
           let swizzledMethod = class_getInstanceMethod(UIView.self, #selector(swizzled_point(inside:with:)))
     else { return }
     method_exchangeImplementations(originalMethod, swizzledMethod)
  }()
  
  private static let swizzleTraitCollection: Void = {
     guard let originalMethod = class_getInstanceMethod(UIView.self, #selector(traitCollectionDidChange(_:))),
           let swizzledMethod = class_getInstanceMethod(UIView.self, #selector(swizzled_traitCollectionDidChange(_:)))
     else { return }
     method_exchangeImplementations(originalMethod, swizzledMethod)
  }()
  
  @objc func swizzled_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    swizzled_traitCollectionDidChange(previousTraitCollection)
    if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
      if let borderColor = borderColor {
        layer.borderColor = borderColor.resolvedColor(with: traitCollection).cgColor
      }
      if let shadowColor = shadowColor {
        layer.shadowColor = shadowColor.resolvedColor(with: traitCollection).cgColor
      }
    }
  }
  
  @objc func swizzled_point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    bounds.inset(by: hitTestSlop).contains(point)
  }
}

extension UIView {
  public func superview<T: UIView>(matchingType _: T.Type) -> T? {
    var current: UIView? = self
    while let next = current?.superview {
      if let next = next as? T {
        return next
      }
      current = next
    }
    return nil
  }

  public func findSubview<ViewType: UIView>(checker: ((ViewType) -> Bool)? = nil) -> ViewType? {
    for subview in [self] + flattendSubviews.reversed() {
      if let subview = subview as? ViewType, checker?(subview) != false {
        return subview
      }
    }
    return nil
  }

  public func contains(view: UIView) -> Bool {
    if view == self {
      return true
    }
    return subviews.contains(where: { $0.contains(view: view) })
  }
}

extension UIView {
  open var parentViewController: UIViewController? {
    var responder: UIResponder? = self
    while responder is UIView {
      responder = responder!.next
    }
    return responder as? UIViewController
  }
  
  open var presentedViewController: UIViewController? {
    parentViewController?.presentedViewController
  }

  open var presentingViewController: UIViewController? {
    parentViewController?.presentingViewController
  }

  open func present(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
    parentViewController?.present(viewController, animated: true, completion: completion)
  }

  open func push(_ viewController: UIViewController) {
    parentViewController?.navigationController?.pushViewController(viewController, animated: true)
  }

  @objc open func dismiss(completion: (() -> Void)? = nil) {
    guard let viewController = parentViewController else {
      return
    }
    if let navVC = viewController.navigationController, navVC.viewControllers.count > 1 {
      navVC.popViewController(animated: true)
      completion?()
    } else {
      viewController.dismiss(animated: true, completion: completion)
    }
  }

  @objc open func dismissModal(completion: (() -> Void)? = nil) {
    guard let viewController = parentViewController else {
      return
    }
    viewController.dismiss(animated: true, completion: completion)
  }
}

extension UIView {
  /// Create image snapshot of view.
  ///
  /// - Parameters:
  ///   - rect: The coordinates (in the view's own coordinate space) to be captured. If omitted, the entire `bounds` will be captured.
  ///   - afterScreenUpdates: A Boolean value that indicates whether the snapshot should be rendered after recent changes have been incorporated. Specify the value false if you want to render a snapshot in the view hierarchy’s current state, which might not include recent changes. Defaults to `true`.
  ///
  /// - Returns: The `UIImage` snapshot.

  public func snapshot(of rect: CGRect? = nil, afterScreenUpdates _: Bool = true) -> UIImage {
    UIGraphicsImageRenderer(bounds: rect ?? bounds).image { _ in
      drawHierarchy(in: bounds, afterScreenUpdates: true)
    }
  }

  public var flattendSubviews: [UIView] {
    subviews + subviews.flatMap { $0.flattendSubviews }
  }

  public func closestViewMatchingType<ViewType: UIView>(_: ViewType.Type) -> ViewType? {
    closestViewPassingTest {
      $0 is ViewType
    } as? ViewType
  }

  public func closestViewPassingTest(_ test: (UIView) -> Bool) -> UIView? {
    var current: UIView? = self.superview
    while current != nil {
      if test(current!) {
        return current
      }
      current = current?.superview
    }
    return nil
  }
}
