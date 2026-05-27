//
//  UIKitScreenShieldKitTests.swift
//  ScreenShieldKit
//
//  Copyright (c) 2026 Kyle-Ye
//  SPDX-License-Identifier: MIT

#if canImport(UIKit)
import Foundation
import ScreenShieldKit
import UIKit
import Testing

@MainActor
struct UIKitScreenShieldKitTests {
    @Test
    func hiddenFromCapture() {
        let view = UIView(frame: .zero)
        let canSetCaptureVisibility = view.layer.responds(to: NSSelectorFromString("disableUpdateMask"))

        #expect(view.hiddenFromCapture() == canSetCaptureVisibility)
        #expect(view.hiddenFromCapture(false) == canSetCaptureVisibility)
    }
}
#endif
