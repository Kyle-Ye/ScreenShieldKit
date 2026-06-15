# ``ScreenShieldKit``

Hide sensitive user interface content from screenshots, screen recordings, and other system captures.

## Overview

ScreenShieldKit provides small capture-hiding extensions for UIKit, SwiftUI, and lower-level layer-backed views. Use the API that matches the level where your sensitive content is composed.

For UIKit views, call ``UIKit/UIView/hiddenFromCapture(_:)`` on the view you want to protect. For custom layer-backed rendering, call ``QuartzCore/CALayer/hiddenFromCapture(_:)`` directly. For SwiftUI views on iOS 18 and newer platform releases, use ``SwiftUICore/View/hiddenFromCapture(_:)`` as a view modifier.

> Important: ScreenShieldKit relies on private platform behavior. Keep capture protection focused on sensitive content, and verify the result on every OS release you support.

## Topics

### Essentials

- <doc:ProtectingCapturedContent>

### UIKit

- ``UIKit/UIView/hiddenFromCapture(_:)``

### SwiftUI

- <doc:ProtectingSwiftUIViews>
- ``SwiftUICore/View/hiddenFromCapture(_:)``

### Layers

- ``QuartzCore/CALayer/hiddenFromCapture(_:)``

### Extended Modules

- ``QuartzCore``
- ``UIKit``

### Credits

- <doc:Acknowledgements>
