// swift-tools-version: 6.1

import PackageDescription

#if TUIST
import struct ProjectDescription.PackageSettings
import struct ProjectDescription.Settings

let packageSettings = PackageSettings(
    targetSettings: [
        "ScreenShieldKit": Settings.settings(base: [
            "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "$(inherited) OPENSWIFTUI",
        ]),
    ]
)
#endif

let package = Package(
    name: "ScreenShieldKitExamplesDependencies",
    dependencies: [
        .package(
            path: "../..",
            traits: [
                .trait(name: "OpenSwiftUI"),
            ]
        ),
    ]
)
