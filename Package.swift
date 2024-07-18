// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftToolbox",
    platforms: [
        .iOS(.v12), .macOS(.v10_14), .macCatalyst(.v13)
        ],
    products: [
        .library(
            name: "SwiftToolbox",
            targets: ["SwiftToolbox"])
    ],
    dependencies: [
        .package(url: "https://github.com/themomax/swift-docc-plugin", branch: "add-extended-types-flag")
    ],
    targets: [
        .target(
            name: "SwiftToolbox",
            dependencies: []),
        .testTarget(
            name: "SwiftToolboxTests",
            dependencies: ["SwiftToolbox"],
            resources: [
                .process("Resources")
            ])
    ]
)
