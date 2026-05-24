//
//  OpenSwiftUIExampleUITests.swift
//  OpenSwiftUIExampleUITests
//
//  Created by Kyle on 2026/05/25.
//

import UIKit
import XCTest

final class OpenSwiftUIExampleUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    @MainActor
    func testVisibleProtectedContentScreenshot() throws {
        let app = XCUIApplication()
        app.launch()

        assertScreenshot(color: .blue)
    }

    @MainActor
    func testHiddenProtectedContentScreenshot() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--hide-protected-content"]
        app.launch()

        assertScreenshot(color: .red)
    }
}
