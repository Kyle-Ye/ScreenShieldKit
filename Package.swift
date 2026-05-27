// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "ScreenShieldKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "ScreenShieldKit", targets: ["ScreenShieldKit"]),
    ],
    traits: [
        .trait(
            name: "OpenSwiftUI",
            description: "Enable OpenSwiftUI-specific view extensions."
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI-spm.git",
            from: "0.18.1",
        ),
    ],
    targets: [
        .target(
            name: "ScreenShieldKit",
            dependencies: [
                .product(
                    name: "OpenSwiftUI",
                    package: "OpenSwiftUI-spm",
                    condition: .when(traits: ["OpenSwiftUI"])
                ),
            ]
        ),
        .testTarget(
            name: "ScreenShieldKitTests",
            dependencies: [
                "ScreenShieldKit",
                .product(
                    name: "OpenSwiftUI",
                    package: "OpenSwiftUI-spm",
                    condition: .when(traits: ["OpenSwiftUI"])
                ),
            ]
        ),
    ]
)
