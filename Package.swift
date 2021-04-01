// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SQDevKit",
    platforms: [.iOS(.v10)],
    products: [
        .library(name: "SQExtensions", targets: ["SQExtensions"]),
        .library(name: "SQKeyboard", targets: ["SQKeyboard"]),
        .library(name: "SQLists", targets: ["SQLists"]),
        .library(name: "VUPER", targets: ["VUPER"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/sequenia/SQDifferenceKit.git",
            .upToNextMajor(from: "0.2.2")
        )
    ],
    targets: [
        .target(name: "SQExtensions", path: "./Sources/Extensions"),
        .target(name: "SQKeyboard", path: "./Sources/Keyboard"),
        .target(
            name: "SQLists",
            dependencies: [
                .product(name: "SQDifferenceKit", package: "SQDifferenceKit")
            ],
            path: "./Sources/Lists"
        ),
        .target(
            name: "VUPER",
            dependencies: ["SQExtensions"],
            path: "./Sources/VUPER"
        )
    ]
)
