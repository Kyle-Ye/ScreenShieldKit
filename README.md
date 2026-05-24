# ScreenShieldKit

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FKyle-Ye%2FScreenShieldKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/Kyle-Ye/ScreenShieldKit) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FKyle-Ye%2FScreenShieldKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/Kyle-Ye/ScreenShieldKit)

A Swift framework to hide UIView/NSView/CALayer, and SwiftUI views on iOS 18 and newer, from being captured when taking screenshots.

## Overview

| **Workflow** | **Status** |
|-|:-|
| **iOS UI Tests** | [![iOS UI Tests](https://github.com/Kyle-Ye/ScreenShieldKit/actions/workflows/ios.yml/badge.svg)](https://github.com/Kyle-Ye/ScreenShieldKit/actions/workflows/ios.yml) |

![Demo](Resources/preview.png)

## Getting Started

In your `Package.swift` file, add the following dependency to your `dependencies` argument:

```swift
.package(url: "https://github.com/Kyle-Ye/ScreenShieldKit.git", from: "0.1.0"),
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
OpenSwiftUI-spm binary package from version 0.18.0.

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

Detailed documentation for ScreenShieldKit can be found on the [Swift Package Index](https://swiftpackageindex.com/Kyle-Ye/ScreenShieldKit/main/documentation/screenshieldkit).

## License

See LICENSE file - MIT

## Acknowledgements

- [@NSAntoine](https://github.com/NSAntoine) for the CALayer capture hiding write-up: https://nsantoine.dev/posts/CALayerCaptureHiding
- [@Kyle-Ye](https://github.com/Kyle-Ye) for the SwiftUI capture hiding notes: https://kyleye.top/posts/swiftui-hidden-from-capture
