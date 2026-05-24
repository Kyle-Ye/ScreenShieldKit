//
//  UIKitExampleUITests.swift
//  UIKitExampleUITests
//
//  Created by Kyle on 2025/2/17.
//

import UIKit
import XCTest

final class UIKitExampleUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    @MainActor
    func testHostAppScreenshot() throws {
        let app = XCUIApplication()
        app.launch()

        assertScreenshot(color: .blue)

        SimulatorShaker.performShake()
        sleep(2) // Sleep some time to wait for the host app handle shake event
        assertScreenshot(color: .red)

        SimulatorShaker.performShake()
        sleep(2) // Sleep some time to wait for the host app handle shake event
        assertScreenshot(color: .blue)

        let toggle = app.switches.element
        toggle.tap()
        assertScreenshot(color: .red)

        toggle.tap()
        assertScreenshot(color: .blue)
    }
}
