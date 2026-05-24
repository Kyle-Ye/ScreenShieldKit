// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "ScreenShieldKit",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .tvOS(.v18),
        .watchOS(.v11),
        .visionOS(.v2),
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
            from: "0.18.0"
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
            ],
            swiftSettings: [
                .define("OPENSWIFTUI", .when(traits: ["OpenSwiftUI"])),
            ]
        ),
    ]
)
