// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "CaptureHider",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "CaptureHider", targets: ["CaptureHider"]),
    ],
    targets: [
        .target(name: "CaptureHider"),
    ]
)
