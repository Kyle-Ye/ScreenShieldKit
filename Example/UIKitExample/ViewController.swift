//
//  ViewController.swift
//  UIKitExample
//
//  Created by Kyle on 2025/2/17.
//

import ScreenShieldKit
import UIKit

final class ViewController: UIViewController {
    private lazy var captureToggle: UISwitch = {
        let switchView = UISwitch()
        switchView.addTarget(self, action: #selector(toggleChanged(_:)), for: .valueChanged)
        switchView.hiddenFromCapture()
        return switchView
    }()

    private lazy var blueColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(blueColorView)
        view.addSubview(captureToggle)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsUpdateOfHomeIndicatorAutoHidden()
        setNeedsUpdateOfScreenEdgesDeferringSystemGestures()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        blueColorView.frame = view.bounds
        captureToggle.center = view.center
    }

    @objc
    private func toggleChanged(_ sender: UISwitch) {
        blueColorView.hiddenFromCapture(sender.isOn)
    }

    override var prefersStatusBarHidden: Bool { true }

    override var prefersHomeIndicatorAutoHidden: Bool { true }

    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge { .all }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            captureToggle.isOn.toggle()
            captureToggle.sendActions(for: .valueChanged)
        }
    }
}
