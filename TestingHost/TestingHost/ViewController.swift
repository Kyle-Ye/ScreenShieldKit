//
//  ViewController.swift
//  TestingHost
//
//  Created by Kyle on 2025/2/17.
//

import UIKit
import ScreenShieldKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        let subview = UIView(frame: view.bounds)
        view.addSubview(subview)
        subview.backgroundColor = .blue
    }

    override var prefersStatusBarHidden: Bool { true }

    override var prefersHomeIndicatorAutoHidden: Bool { true }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            view.subviews.forEach {
                $0.hideFromCapture()
            }
        }
    }
}
