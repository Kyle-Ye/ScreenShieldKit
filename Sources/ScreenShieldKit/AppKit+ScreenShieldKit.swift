//
//  AppKit+ScreenShieldKit.swift
//  ScreenShieldKit
//
//  Copyright (c) 2025-2026 Kyle-Ye
//  SPDX-License-Identifier: MIT

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import os.log

extension NSView {
    /// Configures the view's visibility in screen captures and recordings.
    ///
    /// This method allows you to control whether the view's content appears in screen recordings,
    /// screen captures, and other screen sharing scenarios. When hidden, the view's content will
    /// be replaced with a placeholder or appear blank in captures.
    ///
    /// - Parameter hidden: A boolean value that determines whether to hide the content from screen captures.
    ///                     Set to `true` to hide content, `false` to show content. Defaults to `true`.
    ///
    /// - Returns: A boolean value indicating whether the operation was successful.
    ///           Returns `true` if the visibility was successfully configured, `false` if there was an error.
    ///
    /// - Note: The AppKit path is currently best-effort. On macOS, setting the private
    ///   layer update mask has been observed not to hide `NSView` contents from system
    ///   captures reliably.
    ///
    @discardableResult
    public func hiddenFromCapture(_ hidden: Bool = true) -> Bool {
        guard let layer else {
            os_log(.error, log: screenShieldLogger, "NSView is not backed by CALayer")
            return false
        }
        return layer.hiddenFromCapture(hidden)
    }

    /// Configures the view's visibility in screen captures and recordings.
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
