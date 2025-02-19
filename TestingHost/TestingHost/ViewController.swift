//
//  ViewController.swift
//  TestingHost
//
//  Created by Kyle on 2025/2/17.
//

import UIKit
import ScreenShieldKit

class ViewController: UIViewController {
    let hideSubViewSwitch = UISwitch()
    var subview = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        subview.backgroundColor = .blue
        hideSubViewSwitch.backgroundColor = .darkGray
        hideSubViewSwitch.layer.cornerRadius = hideSubViewSwitch.frame.height / 2
        hideSubViewSwitch.hideFromCapture(hide: true)
        
        view.addSubview(subview)
        view.addSubview(hideSubViewSwitch)
        
        subview.frame = view.frame
        hideSubViewSwitch.center = view.center
        
        hideSubViewSwitch.addTarget(self, action: #selector(toggleHideFromCapture),
                                    for: .valueChanged)
    }
    
    @objc func toggleHideFromCapture() {
        subview.hideFromCapture(hide: hideSubViewSwitch.isOn)
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
