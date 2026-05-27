//
//  OpenSwiftUIScreenShieldKitTests.swift
//  ScreenShieldKit
//
//  Copyright (c) 2026 Kyle-Ye
//  SPDX-License-Identifier: MIT

#if OpenSwiftUI && canImport(OpenSwiftUI)
import OpenSwiftUI
import ScreenShieldKit
import Testing

@MainActor
struct OpenSwiftUIScreenShieldKitTests {
    @Test
    func hiddenFromCapture() {
        guard #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) else {
            return
        }

        let _ = Text(verbatim: "Hidden").hiddenFromCapture()
        let _ = Text(verbatim: "Visible").hiddenFromCapture(false)
    }
}
#endif
