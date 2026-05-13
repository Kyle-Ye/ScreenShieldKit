//
//  SwiftUI+ScreenShieldKit.swift
//  ScreenShieldKit
//
//  Created by Kyle on 2026/05/12.
//

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
extension RedactionReasons {
    @_spi(Private)
    public static let screencaptureProhibited: RedactionReasons = .init(rawValue: 1 << 3)
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
private struct ScreenCaptureRedactionModifier: ViewModifier {
    var hide: Bool

    func body(content: Content) -> some View {
        content.transformEnvironment(\.redactionReasons) { reasons in
            reasons.updateScreencaptureProhibition(hide)
        }
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
extension RedactionReasons {
    fileprivate mutating func updateScreencaptureProhibition(_ hide: Bool) {
        if hide {
            insert(.screencaptureProhibited)
        } else {
            remove(.screencaptureProhibited)
        }
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
extension View {
    /// Prevents this view from appearing in screenshots, screen recordings, and other system captures.
    ///
    /// ScreenShieldKit implements this by adding SwiftUI's private screen-capture redaction reason to
    /// the view environment. Passing `false` removes only that capture-protection reason and preserves
    /// any other active redaction reasons from ancestors.
    ///
    /// - Parameter hide: A Boolean value that controls whether the view is hidden from capture.
    ///   The default value is `true`.
    /// - Returns: A view with screen-capture visibility configured.
    public func hideFromCapture(hide: Bool = true) -> some View {
        modifier(ScreenCaptureRedactionModifier(hide: hide))
    }
}
#endif
