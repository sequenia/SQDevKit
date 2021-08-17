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
        .library(name: "SQVUPER", targets: ["SQVUPER"]),
        .library(name: "SQOperations", targets: ["SQOperations"]),
        .library(name: "SQUIKit", targets: ["SQUIKit"])
    ],
    dependencies: [
//        .package(
//            url: "https://github.com/sequenia/SQDifferenceKit.git",
//            .upToNextMajor(from: "0.3.0-beta")
//        ),
        .package(path: "/Users/semenkologrivov/Documents/Workspace/iOS/SQDifferenceKit"),
        .package(
            url: "https://github.com/SwiftyJSON/SwiftyJSON.git",
            .upToNextMajor(from: "5.0.1")
        )
    ],
    targets: [
        .target(
            name: "SQExtensions",
            dependencies: [
                .product(name: "SwiftyJSON", package: "SwiftyJSON")
            ],
            path: "./Sources/Extensions"
        ),
        .target(
            name: "SQKeyboard",
            path: "./Sources/Keyboard"
        ),
        .target(
            name: "SQLists",
            dependencies: [
                "SQExtensions",
                .product(name: "SQDifferenceKit", package: "SQDifferenceKit")
            ],
            path: "./Sources/Lists"
        ),
        .target(
            name: "SQVUPER",
            dependencies: ["SQExtensions"],
            path: "./Sources/VUPER"
        ),
        .target(
            name: "SQOperations",
            dependencies: ["SQExtensions"],
            path: "./Sources/Operations"
        ),
        .target(
            name: "SQUIKit",
            dependencies: [
                "SQExtensions",
                "SQLists",
                .product(name: "SQDifferenceKit", package: "SQDifferenceKit")
            ],
            path: "./Sources/UIKit"
        )
    ]
)
