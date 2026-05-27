# ScreenShieldKit Example

## Generate Project

The recommended setup path is the local setup script:

```shell
./setup.sh
```

The script trusts and installs the tools declared by `Example/mise.toml`, then runs Tuist through `mise exec` so the pinned Tuist version is used.

To run the steps manually:

```shell
mise trust mise.toml
mise install
mise exec -- tuist install
mise exec -- tuist generate --no-open
```

## LookInsideServer

The generated Debug example app targets include LookInsideServer for UI inspection on iOS and macOS. Release configurations exclude the LookInsideServer sources with `EXCLUDED_SOURCE_FILE_NAMES`, so release builds do not include the inspector server.

## Schemes

- `UIKitExample`: UIKit demo and the target app for UI tests.
- `AppKitExample`: macOS AppKit demo.
- `SwiftUIExample`: SwiftUI demo for iOS and macOS.
- `OpenSwiftUIExample`: OpenSwiftUI demo for iOS and macOS.
