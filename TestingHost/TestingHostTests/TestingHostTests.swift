//
//  TestingHostTests.swift
//  TestingHostTests
//
//  Created by Kyle on 2025/2/17.
//

import Testing
import ScreenShieldKit
import UIKit

@MainActor
struct TestingHostTests {
    @Test
    func api() {
        let view = UIView()
        #expect(view.hideFromCapture() == true)
        #expect(view.hideFromCapture(hide: false) == true)
        #expect(view.hideFromCapture(hide: true) == true)

        let layer = view.layer
        #expect(layer.hideFromCapture() == true)
        #expect(layer.hideFromCapture(hide: false) == true)
        #expect(layer.hideFromCapture(hide: true) == true)
    }
}
