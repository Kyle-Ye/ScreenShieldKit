//
//  ViewController.swift
//  TestingHost
//
//  Created by Kyle on 2025/2/17.
//

import UIKit
import ScreenShieldKit

class ViewController: UIViewController {
    private lazy var hideFromCaptureSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.center = self.view.center
        switchView.addTarget(self, action: #selector(toggleChanged(_:)), for: .valueChanged)
        switchView.hideFromCapture()
        return switchView
    }()

    private lazy var blueColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.frame = self.view.bounds
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(blueColorView)
        view.addSubview(hideFromCaptureSwitch)
    }

    @objc
    private func toggleChanged(_ sender: UISwitch) {
        blueColorView.hideFromCapture(hide: sender.isOn)
    }

    override var prefersStatusBarHidden: Bool { true }

    override var prefersHomeIndicatorAutoHidden: Bool { true }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            hideFromCaptureSwitch.isOn.toggle()
            hideFromCaptureSwitch.sendActions(for: .valueChanged)
        }
    }
}
