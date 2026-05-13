import ProjectDescription

let bundleIdPrefix = "top.kyleye.screenshieldkit"

let baseSettings: SettingsDictionary = [
    "CODE_SIGN_STYLE": "Automatic",
    "DEVELOPMENT_TEAM": "VB7MJ8R223",
]

let project = Project(
    name: "ScreenShieldKitExample",
    targets: [
        .target(
            name: "ScreenShieldKitExample",
            destinations: [.iPhone, .iPad],
            product: .app,
            bundleId: "\(bundleIdPrefix).example",
            deploymentTargets: .iOS("18.0"),
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": [:],
                "UIStatusBarHidden": true,
                "UIViewControllerBasedStatusBarAppearance": false,
            ]),
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "ScreenShieldKit"),
            ],
            settings: .settings(base: baseSettings)
        ),
    ]
)
