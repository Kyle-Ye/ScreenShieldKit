// swift-tools-version: 6.1

import Foundation
import PackageDescription

let useSPIInterfaces = Context.environment["SCREENSHIELDKIT_USE_SPI_INTERFACES"].map {
    let enabled = $0 == "1"
    print("SCREENSHIELDKIT_USE_SPI_INTERFACES=\($0) -> \(enabled)")
    return enabled
} ?? false
let packageDirectory = URL(fileURLWithPath: #filePath).deletingLastPathComponent().path
let spiInterfaceSettings: [SwiftSetting] = useSPIInterfaces ? [
    .unsafeFlags([
        "-I", "\(packageDirectory)/Interfaces",
        "-D", "SCREENSHIELDKIT_USE_SPI_INTERFACES",
    ]),
] : []

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
            ],
            swiftSettings: spiInterfaceSettings
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
            ],
            swiftSettings: spiInterfaceSettings
        ),
    ]
)
