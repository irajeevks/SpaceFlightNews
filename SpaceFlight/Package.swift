// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.


import PackageDescription

extension Target.Dependency {
    static var tca: Self {
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
    }
    static var appService: Self {
        .product(name: "AppService", package: "appservice")
    }
}

let package = Package(
    name: "SpaceFlight",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "AppFeature",
            targets: ["AppFeature"]),
        .library(
            name: "ArticlesFeature",
            targets: ["ArticlesFeature"]
        ),
        .library(
            name: "ArticleNavigationFeature",
            targets: ["ArticleNavigationFeature"]
        ),
        .library(
            name: "AppTabsFeature",
            targets: ["AppTabsFeature"]
        ),
        .library(
            name: "FilterFeature",
            targets: ["FilterFeature"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            .upToNextMajor(from: "1.0.0")
        ),
        .package(
            url: "https://github.com/ratnesh-jain/appservice",
            .upToNextMajor(from: "0.0.1")
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "Models", dependencies: []),
        .target(
            name: "UIUtilities",
            dependencies: []
        ),
        .target(
            name: "Service",
            dependencies: [
                .appService,
                .tca,
                "Models",
            ]
        ),
        .target(
            name: "FilterFeature",
            dependencies: [
                .tca,
                "Models"
            ]
        ),
        .target(
            name: "ArticlesFeature",
            dependencies: [
                .tca,
                "UIUtilities",
                "Service",
                "FilterFeature"
            ]
        ),
        .target(
            name: "ArticleDetailsFeature",
            dependencies: [.tca, "UIUtilities"]
        ),
        .target(
            name: "ArticleNavigationFeature",
            dependencies: ["ArticlesFeature", "ArticleDetailsFeature"]
        ),
        .target(
            name: "AppTabsFeature",
            dependencies: ["ArticleNavigationFeature"]
        ),
        .target(
            name: "AppFeature",
            dependencies: ["AppTabsFeature"]
        ),
        .testTarget(
            name: "ArticlesFeatureTests",
            dependencies: ["ArticlesFeature"]
        ),
        .testTarget(
            name: "ArticleNavigationFeatureTests",
            dependencies: ["ArticleNavigationFeature"]
        ),
        .testTarget(
            name: "AppTabsFeatureTests",
            dependencies: ["AppTabsFeature"]
        ),
        .testTarget(
            name: "FilterFeatureTests",
            dependencies: ["FilterFeature"]
        ),
    ]
)
