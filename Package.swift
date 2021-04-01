// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SQDevKit",
    platforms: [.iOS(.v10)],
    products: [
        .library(name: "SQExtensions", targets: ["SQExtensions"]),
        .library(name: "SQDifferenceKit", targets: ["SQDifferenceKit"]),
        .library(name: "SQKeyboard", targets: ["SQKeyboard"]),
        .library(name: "SQLists", targets: ["SQLists"]),
        .library(name: "VUPER", targets: ["VUPER"]),
        .library(name: "SQDevKit",
                 targets: [
                    "SQExtensions",
                    "SQDifferenceKit",
                    "SQKeyboard",
                    "SQLists",
                    "VUPER"
                 ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ra1028/DifferenceKit.git", from: "1.1.5")
    ],
    targets: [
        .target(name: "SQExtensions", path: "./Sources/Extensions"),
        .target(
            name: "SQDifferenceKit",
            dependencies: [
                .product(name: "DifferenceKit", package: "DifferenceKit")
            ],
            path: "./Sources/DifferenceKit"
        ),
        .target(name: "SQKeyboard", path: "./Sources/Keyboard"),
        .target(name: "SQLists", dependencies: ["SQDifferenceKit"], path: "./Sources/Lists"),
        .target(name: "VUPER", path: "./Sources/VUPER")
    ]
)
