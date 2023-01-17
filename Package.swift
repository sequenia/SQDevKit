// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SQDevKit",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "SQEntities", targets: ["SQEntities"]),
        .library(name: "SQExtensions", targets: ["SQExtensions"]),
        .library(name: "SQKeyboard", targets: ["SQKeyboard"]),
        .library(name: "SQCompositionLists", targets: ["SQCompositionLists"]),
        .library(name: "SQUIKit", targets: ["SQUIKit"]),
        .library(name: "SQDefaults", targets: ["SQDefaults"]),
        .library(name: "SQUtils", targets: ["SQUtils"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/SwiftyJSON/SwiftyJSON.git",
            .upToNextMajor(from: "5.0.1")
        ),
        .package(
            url: "https://github.com/SnapKit/SnapKit.git",
            .upToNextMajor(from: "5.6.0")
        ),
        .package(
            url: "https://github.com/luximetr/AnyFormatKit.git",
            .upToNextMajor(from: "2.5.2")
        )
    ],
    targets: [
        .target(
            name: "SQExtensions",
            dependencies: [
                .product(name: "SwiftyJSON", package: "SwiftyJSON"),
                .product(name: "SnapKit", package: "SnapKit")
            ],
            path: "./Sources/Extensions"
        ),
        .target(
            name: "SQEntities",
            dependencies: [
                "SQExtensions",
                .product(name: "SwiftyJSON", package: "SwiftyJSON"),
            ],
            path: "./Sources/Entities"
        ),
        .target(
            name: "SQKeyboard",
            path: "./Sources/Keyboard"
        ),
        .target(
            name: "SQCompositionLists",
            dependencies: [
                "SQExtensions",
                "SQEntities"
            ],
            path: "./Sources/CompositionLists"
        ),
        .target(
            name: "SQUIKit",
            dependencies: [
                "SQExtensions",
                "SQEntities",
                "SQCompositionLists",
                .product(name: "AnyFormatKit", package: "AnyFormatKit"),
            ],
            path: "./Sources/UIKit"
        ),
        .target(
            name: "SQDefaults",
            dependencies: ["SQExtensions"],
            path: "./Sources/Defaults"
        ),
        .target(
            name: "SQUtils",
            path: "./Sources/Utils"
        )
    ]
)
