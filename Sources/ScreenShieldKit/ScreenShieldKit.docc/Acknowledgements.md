# Acknowledgements

Recognize the research and notes that shaped ScreenShieldKit's capture-protection APIs.

@Metadata {
    @PageImage(source: "sparkle", alt: "Sparkle icon.", purpose: icon)
}

## Overview

ScreenShieldKit builds on community research into capture-protection behavior across UIKit, SwiftUI, and Core Animation. The package turns those findings into small APIs that can be applied at the boundary where sensitive content is rendered.

Capture protection is intentionally scoped. Mark the specific view, SwiftUI branch, or layer that owns private content, and leave the rest of the interface visible to screenshots, recordings, and sharing flows.

> Important: These APIs rely on private platform behavior. Treat them as a focused privacy aid, keep usage limited to sensitive content, and verify the result on every OS release you support.

## Credits

![Cover image for NSAntoine's CALayer capture hiding write-up.](https://nsantoine.dev/CALayerCaptureHiding.md.png)

[@NSAntoine](https://github.com/NSAntoine) for the [CALayer capture hiding write-up](https://nsantoine.dev/posts/CALayerCaptureHiding/), which documents the layer-level behavior that ScreenShieldKit wraps for UIKit, AppKit, and Core Animation callers.

![Cover image for Kyle Ye's SwiftUI capture hiding notes.](https://kyleye.top/images/swiftui-hidden-from-capture/cover.png)

[@Kyle-Ye](https://github.com/Kyle-Ye) for the [SwiftUI capture hiding notes](https://kyleye.top/posts/swiftui-hidden-from-capture), which describe the SwiftUI redaction reason used by the SwiftUI API.

## See Also

- <doc:ProtectingCapturedContent>
- <doc:ProtectingSwiftUIViews>
