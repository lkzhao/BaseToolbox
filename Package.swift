// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "BaseToolbox",
  platforms: [
    .iOS("13.0"),
    .tvOS("15.0")
  ],
  products: [
    .library(
      name: "BaseToolbox",
      targets: ["BaseToolbox", "BaseToolboxUIKit", "BaseToolboxCoreGraphics", "BaseToolboxFoundation"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "BaseToolbox",
      dependencies: ["BaseToolboxUIKit", "BaseToolboxCoreGraphics", "BaseToolboxFoundation"]),
    .target(
      name: "BaseToolboxUIKit",
      dependencies: ["BaseToolboxCoreGraphics"]),
    .target(
      name: "BaseToolboxCoreGraphics",
      dependencies: ["BaseToolboxFoundation"]),
    .target(
      name: "BaseToolboxFoundation",
      dependencies: []),
  ]
)
