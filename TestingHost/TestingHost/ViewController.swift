//
//  ViewController.swift
//  TestingHost
//
//  Created by Kyle on 2025/2/17.
//

import UIKit
import CaptureHider

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.hideFromCapture(hide: true)
    }
}
