// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SQDevKit",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "SQExtensions", targets: ["SQExtensions"]),
        .library(name: "SQKeyboard", targets: ["SQKeyboard"]),
        .library(name: "SQCompositionLists", targets: ["SQCompositionLists"]),
        .library(name: "SQOperations", targets: ["SQOperations"]),
        .library(name: "SQUIKit", targets: ["SQUIKit"]),
        .library(name: "SQDefaults", targets: ["SQDefaults"]),
        .library(name: "SQEntities", targets: ["SQEntities"])
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
            url: "https://github.com/lukepistrol/SwiftLintPlugin.git",
            from: "0.2.2"
        )
    ],
    targets: [
        .target(
            name: "SQExtensions",
            dependencies: [
                .product(name: "SwiftyJSON", package: "SwiftyJSON"),
                .product(name: "SnapKit", package: "SnapKit")
            ],
            path: "./Sources/Extensions",
            plugins: [
                .plugin(
                    name: "SwiftLint",
                    package: "SwiftLintPlugin"
                )
            ]
        ),
        .target(
            name: "SQEntities",
            dependencies: [
                "SQExtensions",
                .product(name: "SwiftyJSON", package: "SwiftyJSON"),
            ],
            path: "./Sources/Entities",
            plugins: [
                .plugin(
                    name: "SwiftLint",
                    package: "SwiftLintPlugin"
                )
            ]
        ),
        .target(
            name: "SQKeyboard",
            path: "./Sources/Keyboard",
            plugins: [
                .plugin(
                    name: "SwiftLint",
                    package: "SwiftLintPlugin"
                )
            ]
        ),
        .target(
            name: "SQCompositionLists",
            dependencies: [
                "SQExtensions",
                "SQEntities"
            ],
            path: "./Sources/CompositionLists",
            plugins: [
                .plugin(
                    name: "SwiftLint",
                    package: "SwiftLintPlugin"
                )
            ]
        ),
        .target(
            name: "SQOperations",
            dependencies: ["SQExtensions"],
            path: "./Sources/Operations",
            plugins: [
                .plugin(
                    name: "SwiftLint",
                    package: "SwiftLintPlugin"
                )
            ]
        ),
        .target(
            name: "SQUIKit",
            dependencies: [
                "SQExtensions",
                "SQEntities",
                "SQCompositionLists"
            ],
            path: "./Sources/UIKit",
            plugins: [
                .plugin(
                    name: "SwiftLint",
                    package: "SwiftLintPlugin"
                )
            ]
        ),
        .target(
            name: "SQDefaults",
            dependencies: ["SQExtensions"],
            path: "./Sources/Defaults",
            plugins: [
                .plugin(
                    name: "SwiftLint",
                    package: "SwiftLintPlugin"
                )
            ]
        ),
    ]
)
