// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AnyUserDefaults",
    products: [
        .library(
            name: "AnyUserDefaults",
            targets: ["AnyUserDefaults"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "AnyUserDefaults",
            dependencies: []),
        .testTarget(
            name: "AnyUserDefaultsTests",
            dependencies: ["AnyUserDefaults"]),
    ]
)
