//
//  UIKit+ScreenShieldKit.swift
//  ScreenShieldKit
//
//  Copyright (c) 2025-2026 Kyle-Ye
//  SPDX-License-Identifier: MIT

#if canImport(UIKit)
import UIKit

extension UIView {
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
    /// - Note: This method uses private iOS APIs and may need to be updated if the underlying implementation changes.
    ///
    @discardableResult
    public func hiddenFromCapture(_ hidden: Bool = true) -> Bool {
        layer.hiddenFromCapture(hidden)
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
