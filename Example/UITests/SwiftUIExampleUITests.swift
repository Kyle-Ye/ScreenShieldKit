//
//  SwiftUIExampleUITests.swift
//  SwiftUIExampleUITests
//
//  Created by Kyle on 2026/05/20.
//

import UIKit
import XCTest

final class SwiftUIExampleUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    @MainActor
    func testHostAppScreenshot() throws {
        let app = XCUIApplication()
        app.launch()

        assertScreenshot(color: .blue)

        let toggle = app.switches["captureToggle"]
        toggle.tap()
        assertScreenshot(color: .red)

        toggle.tap()
        assertScreenshot(color: .blue)
    }
}
