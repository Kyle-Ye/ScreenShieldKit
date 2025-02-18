# CaptureHider

A swift framework to hide a UIView from being captured when screenshot is taken.

## Overview

| **Workflow** | **Status** |
|-|:-|
| **iOS UI Tests** | [![iOS UI Tests](https://github.com/Kyle-Ye/CaptureHider/actions/workflows/ios.yml/badge.svg)](https://github.com/Kyle-Ye/CaptureHider/actions/workflows/ios.yml) |

## Getting Started

In your `Package.swift` file, add the following dependency to your `dependencies` argument:

```swift
.package(url: "https://github.com/Kyle-Ye/CaptureHider.git", from: "0.1.0"),
```

Then add the dependency to any targets you've declared in your manifest:

```swift
.target(
    name: "MyTarget", 
    dependencies: [
        .product(name: "CaptureHider", package: "CaptureHider"),
    ]
),
```

## License

See LICENSE file - MIT

## Credits

https://nsantoine.dev/posts/CALayerCaptureHiding