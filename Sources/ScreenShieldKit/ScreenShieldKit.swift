//
//  ScreenShieldKit.swift
//  ScreenShieldKit
//
//  Created by Kyle on 2025/02/17.
//  Creadit: https://nsantoine.dev/posts/CALayerCaptureHiding

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#else
#error("Unsupported platform")
#endif
import os.log

let logger = OSLog(subsystem: "top.kyleye.screenshieldkit", category: "ScreenShieldKit")

extension CALayer {
    /// Configures the layer's visibility in screen captures and recordings.
    ///
    /// This method allows you to control whether the layer's content appears in screen recordings,
    /// screen captures, and other screen sharing scenarios. When hidden, the layer's content will
    /// be replaced with a placeholder or appear blank in captures.
    ///
    /// - Parameter hide: A boolean value that determines whether to hide the content from screen captures.
    ///                   Set to `true` to hide content, `false` to show content. Defaults to `true`.
    ///
    /// - Returns: A boolean value indicating whether the operation was successful.
    ///           Returns `true` if the visibility was successfully configured, `false` if there was an error.
    ///
    /// - Note: This method uses private iOS APIs and may need to be updated if the underlying implementation changes.
    ///
    @discardableResult
    public func hideFromCapture(hide: Bool = true) -> Bool {
        let propertyBase64 = "ZGlzYWJsZVVwZGF0ZU1hc2s=" /* "disableUpdateMask" encoded in base64 */
        guard let propertyData = Data(base64Encoded: propertyBase64),
              let propertyString = String(data: propertyData, encoding: .utf8) else {
            os_log(.error, log: logger, "Couldn't decode property string")
            return false
        }
        guard responds(to: NSSelectorFromString(propertyString)) else {
            os_log(.error, log: logger, "CALayer does not response to selector %@", propertyString)
            return false
        }
        if hide {
            let hideFlag = (1 << 1) | (1 << 4)
            setValue(NSNumber(value: hideFlag), forKey: propertyString)
        } else {
            setValue(NSNumber(value: 0), forKey: propertyString)
        }
        return true
    }
}

#if canImport(UIKit)
extension UIView {
    /// Configures the view's visibility in screen captures and recordings.
    ///
    /// This method allows you to control whether the view's content appears in screen recordings,
    /// screen captures, and other screen sharing scenarios. When hidden, the view's content will
    /// be replaced with a placeholder or appear blank in captures.
    ///
    /// - Parameter hide: A boolean value that determines whether to hide the content from screen captures.
    ///                   Set to `true` to hide content, `false` to show content. Defaults to `true`.
    ///
    /// - Returns: A boolean value indicating whether the operation was successful.
    ///           Returns `true` if the visibility was successfully configured, `false` if there was an error.
    ///
    /// - Note: This method uses private iOS APIs and may need to be updated if the underlying implementation changes.
    ///
    @discardableResult
    public func hideFromCapture(hide: Bool = true) -> Bool {
        layer.hideFromCapture(hide: hide)
    }
}
#elseif canImport(AppKit)
extension NSView {
    /// Configures the view's visibility in screen captures and recordings.
    ///
    /// This method allows you to control whether the view's content appears in screen recordings,
    /// screen captures, and other screen sharing scenarios. When hidden, the view's content will
    /// be replaced with a placeholder or appear blank in captures.
    ///
    /// - Parameter hide: A boolean value that determines whether to hide the content from screen captures.
    ///                   Set to `true` to hide content, `false` to show content. Defaults to `true`.
    ///
    /// - Returns: A boolean value indicating whether the operation was successful.
    ///           Returns `true` if the visibility was successfully configured, `false` if there was an error.
    ///
    /// - Note: This method uses private macOS APIs and may need to be updated if the underlying implementation changes.
    ///
    @discardableResult
    public func hideFromCapture(hide: Bool = true) -> Bool {
        guard let layer else {
            os_log(.error, log: logger, "NSView is not backed by CALayer")
            return false
        }
        return layer.hideFromCapture(hide: hide)
    }
}
#endif
