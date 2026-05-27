//
//  AppKitScreenShieldKitTests.swift
//  ScreenShieldKit
//
//  Copyright (c) 2026 Kyle-Ye
//  SPDX-License-Identifier: MIT

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import Foundation
import QuartzCore
import ScreenShieldKit
import Testing

@MainActor
struct AppKitScreenShieldKitTests {
    @Test
    func withoutBackingLayer() {
        let view = NSView(frame: .zero)
        #expect(view.hiddenFromCapture() == false)
        #expect(view.hiddenFromCapture(false) == false)
    }

    @Test
    func withBackingLayer() {
        let view = NSView(frame: .zero)
        view.wantsLayer = true
        #expect(view.hiddenFromCapture() == true)
        #expect(view.hiddenFromCapture(false) == true)
    }
}

#endif
