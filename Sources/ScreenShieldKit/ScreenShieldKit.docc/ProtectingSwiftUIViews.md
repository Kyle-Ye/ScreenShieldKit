# Protecting SwiftUI Views

Hide a SwiftUI view from screenshots and screen recordings while leaving the rest of the interface visible.

## Overview

Use ``SwiftUICore/View/hiddenFromCapture(_:)`` when sensitive information is composed in SwiftUI. The modifier applies capture protection to the view branch where it appears, so you can protect only the parts of the UI that contain secrets.

This tutorial starts with a simple one-time-code view, makes capture protection conditional, and then shows how to restore normal capture behavior.

## Add ScreenShieldKit to the View

Import ScreenShieldKit next to SwiftUI, then apply ``SwiftUICore/View/hiddenFromCapture(_:)`` to the sensitive view.

```swift
import ScreenShieldKit
import SwiftUI

struct OneTimeCodeView: View {
    let code: String

    var body: some View {
        Text(code)
            .font(.system(.title, design: .monospaced))
            .hiddenFromCapture()
    }
}
```

Only the modified branch is protected. Surrounding labels, buttons, and layout containers remain visible to captures unless you also apply the modifier to them.

## Drive Protection from State

Pass a Boolean value to ``SwiftUICore/View/hiddenFromCapture(_:)`` when protection depends on the current mode.

```swift
struct AccountBalanceView: View {
    @State private var revealsBalance = false
    let balance: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Balance")
                .font(.caption)

            Text(revealsBalance ? balance : "Hidden")
                .hiddenFromCapture(revealsBalance)

            Toggle("Reveal balance", isOn: $revealsBalance)
        }
    }
}
```

In this example, the real balance is hidden from captures only while it is visible on screen. When the UI shows the placeholder text, the view no longer needs capture protection.

## Choose the Right Boundary

Apply ``SwiftUICore/View/hiddenFromCapture(_:)`` at the smallest meaningful boundary that owns the sensitive content. For example, protect a `Text` view that displays a code instead of the entire screen, or protect a custom sensitive panel instead of the whole navigation stack.

If the sensitive content comes from UIKit or a Core Animation layer, use ``UIKit/UIView/hiddenFromCapture(_:)`` or ``QuartzCore/CALayer/hiddenFromCapture(_:)`` instead.

## Verify the Result

After adding capture protection, verify the behavior with screenshots, screen recordings, screen sharing, and any in-app capture flow that matters for your product.

> Important: ScreenShieldKit relies on private platform behavior. Test capture protection on every OS version you support.
