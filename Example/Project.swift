import ProjectDescription

let bundleIdPrefix = "top.kyleye.screenshieldkit"

let baseSettings: SettingsDictionary = [
    "CODE_SIGN_STYLE": "Automatic",
    "DEVELOPMENT_TEAM": "VB7MJ8R223",
]

let appInfoPlist: [String: Plist.Value] = [
    "CFBundleDevelopmentRegion": "$(DEVELOPMENT_LANGUAGE)",
    "CFBundleExecutable": "$(EXECUTABLE_NAME)",
    "CFBundleIdentifier": "$(PRODUCT_BUNDLE_IDENTIFIER)",
    "CFBundleInfoDictionaryVersion": "6.0",
    "CFBundleName": "$(PRODUCT_NAME)",
    "CFBundlePackageType": "APPL",
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
]

let appKitInfoPlist: [String: Plist.Value] = appInfoPlist.merging([
    "LSMinimumSystemVersion": "$(MACOSX_DEPLOYMENT_TARGET)",
    "NSPrincipalClass": "NSApplication",
]) { _, new in
    new
}

let swiftUIInfoPlist: [String: Plist.Value] = [
    "CFBundleDevelopmentRegion": "$(DEVELOPMENT_LANGUAGE)",
    "CFBundleExecutable": "$(EXECUTABLE_NAME)",
    "CFBundleIdentifier": "$(PRODUCT_BUNDLE_IDENTIFIER)",
    "CFBundleInfoDictionaryVersion": "6.0",
    "CFBundleName": "$(PRODUCT_NAME)",
    "CFBundlePackageType": "APPL",
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "LSMinimumSystemVersion": "$(MACOSX_DEPLOYMENT_TARGET)",
    "NSPrincipalClass": "NSApplication",
    "UIApplicationSceneManifest": [
        "UIApplicationSupportsMultipleScenes": false,
        "UISceneConfigurations": [:],
    ],
    "UILaunchScreen": [:],
]

let uikitInfoPlist: [String: Plist.Value] = [
    "UILaunchScreen": [:],
    "UIStatusBarHidden": true,
    "UIViewControllerBasedStatusBarAppearance": true,
    "UIApplicationSceneManifest": [
        "UIApplicationSupportsMultipleScenes": false,
        "UISceneConfigurations": [
            "UIWindowSceneSessionRoleApplication": [
                [
                    "UISceneConfigurationName": "Default Configuration",
                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate",
                ],
            ],
        ],
    ],
]

let project = Project(
    name: "ScreenShieldKitExamples",
    packages: [
        .package(path: ".."),
    ],
    targets: [
        .target(
            name: "UIKitExample",
            destinations: [.iPhone, .iPad],
            product: .app,
            bundleId: "\(bundleIdPrefix).uikit-example",
            deploymentTargets: .iOS("18.0"),
            infoPlist: .extendingDefault(with: uikitInfoPlist),
            sources: ["UIKitExample/**"],
            dependencies: [
                .package(product: "ScreenShieldKit"),
            ],
            settings: .settings(base: baseSettings)
        ),
        .target(
            name: "UIKitExampleTests",
            destinations: [.iPhone, .iPad],
            product: .unitTests,
            bundleId: "\(bundleIdPrefix).uikit-example.tests",
            deploymentTargets: .iOS("18.0"),
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "UIKitExample"),
                .package(product: "ScreenShieldKit"),
            ],
            settings: .settings(base: baseSettings)
        ),
        .target(
            name: "UIKitExampleUITests",
            destinations: [.iPhone, .iPad],
            product: .uiTests,
            bundleId: "\(bundleIdPrefix).uikit-example.uitests",
            deploymentTargets: .iOS("18.0"),
            sources: [
                "UITests/UIKitExampleUITests.swift",
                "UITests/ScreenshotAssertions.swift",
                "UITests/SimulatorShaker.m",
            ],
            dependencies: [
                .target(name: "UIKitExample"),
                .package(product: "ScreenShieldKit"),
            ],
            settings: .settings(base: baseSettings.merging([
                "SWIFT_OBJC_BRIDGING_HEADER": "UITests/UIKitExampleUITests-Bridging-Header.h",
            ]))
        ),
        .target(
            name: "AppKitExample",
            destinations: [.mac],
            product: .app,
            bundleId: "\(bundleIdPrefix).appkit-example",
            deploymentTargets: .macOS("15.0"),
            infoPlist: .dictionary(appKitInfoPlist),
            sources: ["AppKitExample/**"],
            dependencies: [
                .package(product: "ScreenShieldKit"),
            ],
            settings: .settings(base: baseSettings)
        ),
        .target(
            name: "SwiftUIExample",
            destinations: [.iPhone, .iPad, .mac],
            product: .app,
            bundleId: "\(bundleIdPrefix).swiftui-example",
            deploymentTargets: .multiplatform(
                iOS: "18.0",
                macOS: "15.0"
            ),
            infoPlist: .dictionary(swiftUIInfoPlist),
            sources: ["SwiftUIExample/**"],
            dependencies: [
                .package(product: "ScreenShieldKit"),
            ],
            settings: .settings(base: baseSettings)
        ),
        .target(
            name: "SwiftUIExampleUITests",
            destinations: [.iPhone, .iPad],
            product: .uiTests,
            bundleId: "\(bundleIdPrefix).swiftui-example.uitests",
            deploymentTargets: .iOS("18.0"),
            sources: [
                "UITests/SwiftUIExampleUITests.swift",
                "UITests/ScreenshotAssertions.swift",
            ],
            dependencies: [
                .target(name: "SwiftUIExample"),
                .package(product: "ScreenShieldKit"),
            ],
            settings: .settings(base: baseSettings)
        ),
    ],
    schemes: [
        .scheme(
            name: "UIKitExample",
            shared: true,
            buildAction: .buildAction(targets: [
                "UIKitExample",
                "UIKitExampleTests",
                "UIKitExampleUITests",
            ]),
            testAction: .targets([
                "UIKitExampleTests",
                "UIKitExampleUITests",
            ])
        ),
        .scheme(
            name: "AppKitExample",
            shared: true,
            buildAction: .buildAction(targets: [
                "AppKitExample",
            ])
        ),
        .scheme(
            name: "SwiftUIExample",
            shared: true,
            buildAction: .buildAction(targets: [
                "SwiftUIExample",
                "SwiftUIExampleUITests",
            ]),
            testAction: .targets([
                "SwiftUIExampleUITests",
            ])
        ),
    ]
)
