//
//  TestingHostUITests.swift
//  TestingHostUITests
//
//  Created by Kyle on 2025/2/17.
//

import CaptureHider
import iOSSnapshotTestCase
import UIKit
import XCTest

final class TestingHostUITests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
    }

    @MainActor
    func testViewHideFromCapture() {
        let view = UIView(frame: .init(origin: .zero, size: .init(width: 10, height: 10)))
        view.backgroundColor = .red
        FBSnapshotVerifyView(view, identifier: "Red")
        view.hideFromCapture(hide: true)
        FBSnapshotVerifyView(view, identifier: "Hide")
    }

    @MainActor
    func testLayerHideFromCapture() {
        let view = UIView(frame: .init(origin: .zero, size: .init(width: 10, height: 10)))
        view.backgroundColor = .red
        let layer = view.layer
        FBSnapshotVerifyLayer(layer, identifier: "Red")
        layer.hideFromCapture(hide: true)
        FBSnapshotVerifyLayer(layer, identifier: "Hide")
    }
}
