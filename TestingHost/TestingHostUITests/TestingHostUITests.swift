//
//  TestingHostUITests.swift
//  TestingHostUITests
//
//  Created by Kyle on 2025/2/17.
//

import ScreenShieldKit
import iOSSnapshotTestCase
import UIKit
import XCTest

final class TestingHostUITests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
    }

//    @MainActor
//    func testViewHideFromCapture() {
//        let view = UIView(frame: .init(origin: .zero, size: .init(width: 10, height: 10)))
//        view.backgroundColor = .red
//        FBSnapshotVerifyView(view, identifier: "Red")
//        view.hideFromCapture(hide: true)
//        FBSnapshotVerifyView(view, identifier: "Hide")
//        
//    }
//
//    @MainActor
//    func testLayerHideFromCapture() {
//        let view = UIView(frame: .init(origin: .zero, size: .init(width: 10, height: 10)))
//        view.backgroundColor = .red
//        let layer = view.layer
//        FBSnapshotVerifyLayer(layer, identifier: "Red")
//        layer.hideFromCapture(hide: true)
//        FBSnapshotVerifyLayer(layer, identifier: "Hide")
//    }

    @MainActor
    func testHostAppScreenshot() throws {
        let app = XCUIApplication()
        app.launch()
        sleep(5) // Sleep some time to wait for the home indicator to be hidden when screenshot is taken
        let controller = FBSnapshotTestController(test: TestingHostUITests.self)
        controller.referenceImagesDirectory = getReferenceImageDirectory(withDefault: nil)
        controller.imageDiffDirectory = getImageDiffDirectory(withDefault: nil)

        func assertScreenshot(color: UIColor) {
            do {
                let screenshot = XCUIScreen.main.screenshot()
                let image = screenshot.image

                let render = UIGraphicsImageRenderer(bounds: CGRect(origin: .zero, size: image.size))
                let referenceImage = render.image { context in
                    color.setFill()
                    context.fill(render.format.bounds)
                }
                do {
                    try controller.compareReferenceImage(referenceImage, to: image, overallTolerance: 0.0)
                } catch {
                    XCTFail(error.localizedDescription)
                    try controller.saveFailedReferenceImage(referenceImage, test: image, selector: invocation!.selector, identifier: nil)
                }
            } catch {
                XCTFail(error.localizedDescription)
            }
        }

        assertScreenshot(color: .blue)

        SimulatorShaker.performShake()
        sleep(2) // Sleep some time to wait for the host app handle shake event
        assertScreenshot(color: .red)

        SimulatorShaker.performShake()
        sleep(2) // Sleep some time to wait for the host app handle shake event
        assertScreenshot(color: .blue)

        let toggle = app.switches.element
        toggle.tap()
        sleep(5) // Sleep some time to wait for the home indicator to be hidden when screenshot is taken
        assertScreenshot(color: .red)

        toggle.tap()
        sleep(5) // Sleep some time to wait for the home indicator to be hidden when screenshot is taken
        assertScreenshot(color: .blue)


    }
}
