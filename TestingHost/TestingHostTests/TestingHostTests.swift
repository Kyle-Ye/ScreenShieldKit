//
//  TestingHostTests.swift
//  TestingHostTests
//
//  Created by Kyle on 2025/2/17.
//

import Testing
import CaptureHider
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#else
#error("Unsupported platform")
#endif

@MainActor
struct TestingHostTests {
    @Test
    func example() async throws {
        #if canImport(UIKit)
        let view = UIView()
        #elseif canImport(AppKit)
        let view = NSView()
        #endif
        #expect(view.hideViewFromCapture() == true)
        #expect(view.hideViewFromCapture(hide: false) == true)
        #expect(view.hideViewFromCapture(hide: true) == true)
    }
}
