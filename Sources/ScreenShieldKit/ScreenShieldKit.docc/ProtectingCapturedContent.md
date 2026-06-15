# Protecting Captured Content

Apply capture protection at the boundary that owns the sensitive content.

## Overview

ScreenShieldKit exposes the same capture-hiding intent across UIKit views, SwiftUI views, and Core Animation layers. Each API accepts a Boolean value so you can enable protection when sensitive content is visible and disable it when the content becomes safe to capture again.

### Protect a UIKit View

Use ``UIKit/UIView/hiddenFromCapture(_:)`` when the sensitive content is owned by a `UIView` subtree.

```swift
import ScreenShieldKit
import UIKit

let accountNumberView = UILabel()
accountNumberView.text = "**** 1234"
accountNumberView.hiddenFromCapture()
```

Pass `false` to restore normal capture behavior.

```swift
accountNumberView.hiddenFromCapture(false)
```

### Protect a SwiftUI View

Use ``SwiftUICore/View/hiddenFromCapture(_:)`` when the sensitive content is expressed as SwiftUI. The modifier hides the protected branch from screen captures while preserving the rest of the view hierarchy.

```swift
import ScreenShieldKit
import SwiftUI

Text("One-time code: 481926")
    .hiddenFromCapture()
```

You can drive the modifier from state when protection should be conditional.

```swift
Text(secret)
    .hiddenFromCapture(isSensitive)
```

### Protect a Layer

Use ``QuartzCore/CALayer/hiddenFromCapture(_:)`` when you render directly into a `CALayer`, or when a framework hands you a layer instead of a view.

```swift
import QuartzCore
import ScreenShieldKit

previewLayer.hiddenFromCapture()
```

## Choosing an API

Prefer the highest-level API that matches your UI:

- Use ``UIKit/UIView/hiddenFromCapture(_:)`` for UIKit screens and view subtrees.
- Use ``SwiftUICore/View/hiddenFromCapture(_:)`` for SwiftUI content.
- Use ``QuartzCore/CALayer/hiddenFromCapture(_:)`` for custom layers or renderers.

Verify the capture result in screenshots, screen recordings, and the capture or sharing features your app supports.
