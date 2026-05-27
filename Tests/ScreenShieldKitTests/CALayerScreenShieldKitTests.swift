//
//  CALayerScreenShieldKitTests.swift
//  ScreenShieldKit
//
//  Copyright (c) 2026 Kyle-Ye
//  SPDX-License-Identifier: MIT

#if canImport(QuartzCore)
import Foundation
import QuartzCore
import ScreenShieldKit
import Testing

@MainActor
struct CALayerScreenShieldKitTests {
    @Test
    func hiddenFromCapture() {
        let layer = CALayer()
        let canSetCaptureVisibility = layer.responds(to: NSSelectorFromString("disableUpdateMask"))

        #expect(canSetCaptureVisibility == true)
        #expect(layer.hiddenFromCapture() == true)
        #expect(layer.hiddenFromCapture(false) == true)
    }
}

#endif
