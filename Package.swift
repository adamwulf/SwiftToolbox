// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftToolbox",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftToolbox",
            targets: ["SwiftToolbox"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "git@github.com:apple/swift-docc-plugin.git", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftToolbox",
            dependencies: []),
        .testTarget(
            name: "SwiftToolboxTests",
            dependencies: ["SwiftToolbox"])
    ]
)
