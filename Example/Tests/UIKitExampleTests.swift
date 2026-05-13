//
//  UIKitExampleTests.swift
//  UIKitExampleTests
//
//  Created by Kyle on 2025/2/17.
//

import Testing
import ScreenShieldKit
import UIKit

@MainActor
struct UIKitExampleTests {
    @Test
    func api() {
        let view = UIView()
        #expect(view.hiddenFromCapture() == true)
        #expect(view.hiddenFromCapture(false) == true)
        #expect(view.hiddenFromCapture(true) == true)

        let layer = view.layer
        #expect(layer.hiddenFromCapture() == true)
        #expect(layer.hiddenFromCapture(false) == true)
        #expect(layer.hiddenFromCapture(true) == true)
    }
}
