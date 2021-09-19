// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "BaseToolbox",
  platforms: [.iOS(.v13)],
  products: [
    .library(
      name: "BaseToolbox",
      targets: ["BaseToolbox", "BaseToolboxUIKit"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "BaseToolbox",
      dependencies: []),
    .target(
      name: "BaseToolboxUIKit",
      dependencies: ["BaseToolbox"]),
  ]
)
