//
//  CALayer+ScreenShieldKit.swift
//  ScreenShieldKit
//
//  Copyright (c) 2025-2026 Kyle-Ye
//  SPDX-License-Identifier: MIT
//  Credit: https://nsantoine.dev/posts/CALayerCaptureHiding

import Foundation
import os.log

#if canImport(QuartzCore)
import QuartzCore

extension CALayer {
    /// Configures the layer's visibility in screen captures and recordings.
    ///
    /// This method allows you to control whether the layer's content appears in screen recordings,
    /// screen captures, and other screen sharing scenarios. When hidden, the layer's content will
    /// be replaced with a placeholder or appear blank in captures.
    ///
    /// - Parameter hidden: A boolean value that determines whether to hide the content from screen captures.
    ///                     Set to `true` to hide content, `false` to show content. Defaults to `true`.
    ///
    /// - Returns: A boolean value indicating whether the operation was successful.
    ///           Returns `true` if the visibility was successfully configured, `false` if there was an error.
    ///
    /// - Note: This method uses private platform APIs and may need to be updated if the underlying implementation changes.
    ///
    @discardableResult
    public func hiddenFromCapture(_ hidden: Bool = true) -> Bool {
        let propertyBase64 = "ZGlzYWJsZVVwZGF0ZU1hc2s=" /* "disableUpdateMask" encoded in base64 */
        guard let propertyData = Data(base64Encoded: propertyBase64),
              let propertyString = String(data: propertyData, encoding: .utf8) else {
            os_log(.error, log: screenShieldLogger, "Couldn't decode property string")
            return false
        }
        guard responds(to: NSSelectorFromString(propertyString)) else {
            os_log(.error, log: screenShieldLogger, "CALayer does not respond to selector %@", propertyString)
            return false
        }
        if hidden {
            let hideFlag = (1 << 1) | (1 << 4)
            setValue(NSNumber(value: hideFlag), forKey: propertyString)
        } else {
            setValue(NSNumber(value: 0), forKey: propertyString)
        }
        return true
    }

    /// Configures the layer's visibility in screen captures and recordings.
    ///
    /// - Parameter hide: A boolean value that determines whether to hide the content from screen captures.
    /// - Returns: A boolean value indicating whether the operation was successful.
    ///
    /// - Deprecated: Use ``hiddenFromCapture(_:)`` instead.
    @available(*, deprecated, renamed: "hiddenFromCapture(_:)")
    @discardableResult
    public func hideFromCapture(hide: Bool = true) -> Bool {
        hiddenFromCapture(hide)
    }
}
#endif
