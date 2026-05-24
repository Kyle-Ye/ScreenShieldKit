//
//  OpenSwiftUI+ScreenShieldKit.swift
//  ScreenShieldKit
//
//  Created by Kyle on 2026/05/24.
//

#if OPENSWIFTUI && canImport(OpenSwiftUI)
import OpenSwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
private extension RedactionReasons {
    static let screenShieldScreencaptureProhibited: RedactionReasons = .init(rawValue: 1 << 3)
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
private struct OpenSwiftUIScreenCaptureRedactionModifier: ViewModifier {
    var hidden: Bool

    func body(content: Content) -> some View {
        if hidden {
            content
                // OpenSwiftUI 0.18.0 only forwards the capture-hiding display
                // property through the privacy-sensitive renderer effect path.
                .privacySensitive(true)
                .transformEnvironment(\.redactionReasons) { reasons in
                    reasons.insert(.screenShieldScreencaptureProhibited)
                }
        } else {
            content
                .transformEnvironment(\.redactionReasons) { reasons in
                    reasons.remove(.screenShieldScreencaptureProhibited)
                }
        }
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
extension View {
    /// Prevents this OpenSwiftUI view from appearing in screenshots, screen recordings, and other system captures.
    ///
    /// Build ScreenShieldKit with the `OpenSwiftUI` package trait to enable this extension.
    ///
    /// - Parameter hidden: A Boolean value that controls whether the view is hidden from capture.
    ///   The default value is `true`.
    /// - Returns: A view with screen-capture visibility configured.
    public func hiddenFromCapture(_ hidden: Bool = true) -> some View {
        modifier(OpenSwiftUIScreenCaptureRedactionModifier(hidden: hidden))
    }
}
#endif
