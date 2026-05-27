//
//  SwiftUIScreenShieldKitTests.swift
//  ScreenShieldKit
//
//  Copyright (c) 2026 Kyle-Ye
//  SPDX-License-Identifier: MIT

#if canImport(SwiftUI)
import ScreenShieldKit
import SwiftUI
import Testing

@MainActor
struct SwiftUIScreenShieldKitTests {
    @Test
    func hiddenFromCapture() {
        guard #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) else {
            return
        }

        let _ = Text("Hidden").hiddenFromCapture()
        let _ = Text("Visible").hiddenFromCapture(false)
    }
}
#endif
