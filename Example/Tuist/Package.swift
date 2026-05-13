// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "ExampleDependencies",
    dependencies: [
        .package(path: "../../"),
    ]
)
