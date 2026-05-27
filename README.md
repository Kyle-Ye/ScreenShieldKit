# ScreenShieldKit

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FKyle-Ye%2FScreenShieldKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/Kyle-Ye/ScreenShieldKit) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FKyle-Ye%2FScreenShieldKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/Kyle-Ye/ScreenShieldKit)

A Swift framework to hide UIView/NSView/CALayer, and SwiftUI views on iOS 18 and newer, from being captured when taking screenshots.

## Overview

| **Coverage** | **Workflow** | **Matrix** | **Status** |
|-|-|-|:-|
| Package public API | [`package.yml`](.github/workflows/package.yml) | `swift test --disable-default-traits` and `swift test --traits OpenSwiftUI` on macOS 15/Xcode 16.4 and macOS 26/Xcode 26.3 | [![Package Tests](https://github.com/Kyle-Ye/ScreenShieldKit/actions/workflows/package.yml/badge.svg)](https://github.com/Kyle-Ye/ScreenShieldKit/actions/workflows/package.yml) |
| UIKit example UI tests | [`example_uikit.yml`](.github/workflows/example_uikit.yml) | iOS 18.5 on Xcode 16.4 and iOS 26.2 on Xcode 26.3 | [![UIKit Example Tests](https://github.com/Kyle-Ye/ScreenShieldKit/actions/workflows/example_uikit.yml/badge.svg)](https://github.com/Kyle-Ye/ScreenShieldKit/actions/workflows/example_uikit.yml) |
| SwiftUI example UI tests | [`example_swiftui.yml`](.github/workflows/example_swiftui.yml) | iOS 18.5 on Xcode 16.4 and iOS 26.2 on Xcode 26.3 | [![SwiftUI Example Tests](https://github.com/Kyle-Ye/ScreenShieldKit/actions/workflows/example_swiftui.yml/badge.svg)](https://github.com/Kyle-Ye/ScreenShieldKit/actions/workflows/example_swiftui.yml) |
| OpenSwiftUI example UI tests | [`example_openswiftui.yml`](.github/workflows/example_openswiftui.yml) | iOS 18.5 on Xcode 16.4 and iOS 26.2 on Xcode 26.3 | [![OpenSwiftUI Example Tests](https://github.com/Kyle-Ye/ScreenShieldKit/actions/workflows/example_openswiftui.yml/badge.svg)](https://github.com/Kyle-Ye/ScreenShieldKit/actions/workflows/example_openswiftui.yml) |

![Demo](Resources/preview.png)

## Getting Started

In your `Package.swift` file, add the following dependency to your `dependencies` argument:

```swift
.package(url: "https://github.com/Kyle-Ye/ScreenShieldKit.git", from: "0.2.0"),
```

Then add the dependency to any targets you've declared in your manifest:

```swift
.target(
    name: "MyTarget", 
    dependencies: [
        .product(name: "ScreenShieldKit", package: "ScreenShieldKit"),
    ]
),
```

## Usage

Instead of wrapping your view in a secure UITextField or [ScreenShieldView](https://github.com/RyukieSama/Swifty),

you can just directly call the `hiddenFromCapture(_:)` API on your view or layer.

```swift
import ScreenShieldKit

let view = UIView(frame: .zero)
view.hiddenFromCapture(true)

// Restore the behavior
view.hiddenFromCapture(false)
```

For SwiftUI on iOS 18, macOS 15, tvOS 18, watchOS 11, and visionOS 2 or newer:

```swift
import ScreenShieldKit
import SwiftUI

Text("Sensitive content")
    .hiddenFromCapture()
```

For OpenSwiftUI, enable the package trait. The dependency uses the
OpenSwiftUI-spm binary package from version 0.18.1.

```sh
swift build --traits OpenSwiftUI
```

```swift
import OpenSwiftUI
import ScreenShieldKit

Text("Sensitive content")
    .hiddenFromCapture()
```

AppKit support is best-effort. The current implementation uses the same private
layer update mask path as UIKit, but that has been observed not to hide `NSView`
contents from macOS system captures reliably.

## Examples

The example apps are managed by Tuist:

```sh
cd Example
mise trust --yes
mise install
mise exec -- tuist install
mise exec -- tuist generate --no-open
```

Available schemes:

- `UIKitExample`: UIKit demo and the target app for UI tests.
- `AppKitExample`: macOS AppKit demo.
- `SwiftUIExample`: SwiftUI demo for iOS and macOS.
- `OpenSwiftUIExample`: OpenSwiftUI demo for iOS and macOS.

Detailed documentation for ScreenShieldKit can be found on the [Swift Package Index](https://swiftpackageindex.com/Kyle-Ye/ScreenShieldKit/main/documentation/screenshieldkit).

## License

See LICENSE file - MIT

## Acknowledgements

- [@NSAntoine](https://github.com/NSAntoine) for the CALayer capture hiding write-up: https://nsantoine.dev/posts/CALayerCaptureHiding
- [@Kyle-Ye](https://github.com/Kyle-Ye) for the SwiftUI capture hiding notes: https://kyleye.top/posts/swiftui-hidden-from-capture
