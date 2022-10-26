// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SQDevKit",
    platforms: [.iOS(.v11)],
    products: [
        .library(name: "SQExtensions", targets: ["SQExtensions"]),
        .library(name: "SQKeyboard", targets: ["SQKeyboard"]),
        .library(name: "SQLists", targets: ["SQLists"]),
        .library(name: "SQCompositionLists", targets: ["SQCompositionLists"]),
        .library(name: "SQVUPER", targets: ["SQVUPER"]),
        .library(name: "SQOperations", targets: ["SQOperations"]),
        .library(name: "SQUIKit", targets: ["SQUIKit"]),
        .library(name: "SQDefaults", targets: ["SQDefaults"]),
        .library(name: "SQEntities", targets: ["SQEntities"]),
        .plugin(name: "SQSwiftLint", targets: ["SQSwiftLint"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/sequenia/SQDifferenceKit.git",
            .upToNextMajor(from: "1.0.1")
        ),
        .package(
            url: "https://github.com/SwiftyJSON/SwiftyJSON.git",
            .upToNextMajor(from: "5.0.1")
        ),
        .package(
            url: "https://github.com/SnapKit/SnapKit.git",
            .upToNextMajor(from: "5.6.0")
        ),
        .package(
            url: "https://github.com/realm/SwiftLint.git",
            .upToNextMajor(from: "0.49.1")
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
            name: "SQCompositionLists",
            dependencies: [
                "SQExtensions",
                "SQEntities"
            ],
            path: "./Sources/CompositionLists"
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
                "SQEntities",
                "SQCompositionLists",
                .product(name: "SQDifferenceKit", package: "SQDifferenceKit")
            ],
            path: "./Sources/UIKit"
        ),
        .target(
            name: "SQDefaults",
            dependencies: ["SQExtensions"],
            path: "./Sources/Defaults"
        ),
        .target(
            name: "SQEntities",
            dependencies: [
                "SQExtensions",
                .product(name: "SwiftyJSON", package: "SwiftyJSON"),
            ],
            path: "./Sources/Entities"
        ),
        .plugin(
            name: "SQSwiftLint",
            capability: .buildTool(),
            dependencies: [
                .product(name: "swiftlint", package: "SwiftLint"),
            ],
            path: "./Sources/Plugins"
        ),
    ]
)
