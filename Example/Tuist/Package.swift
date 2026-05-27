// swift-tools-version: 6.1

import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
    productTypes: [
        "LookInsideServer": .framework,
    ],
    productDestinations: [
        "LookInsideServer": [.iPhone, .iPad, .mac],
    ],
    targetSettings: [
        "ScreenShieldKit": Settings.settings(base: [
            // TODO: Xcode does not support enable trait yet
            "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "$(inherited) OpenSwiftUI",
        ]),
    ]
)
#endif

let package = PackageDescription.Package(
    name: "ScreenShieldKitExamplesDependencies",
    dependencies: [
        .package(
            path: "../..",
            traits: [
                .trait(name: "OpenSwiftUI"),
            ]
        ),
        .package(url: "https://github.com/LookInsideApp/LookInside-Release.git", from: "0.2.2"),
    ]
)
