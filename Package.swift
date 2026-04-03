// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "swift-feature-flags",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(name: "FeatureFlags", targets: ["FeatureFlags"])
    ],
    targets: [
        .target(
            name: "FeatureFlags",
            path: "Sources/FeatureFlags"
        ),
        .testTarget(
            name: "FeatureFlagsTests",
            dependencies: ["FeatureFlags"],
            path: "Tests/FeatureFlagsTests"
        )
    ]
)
