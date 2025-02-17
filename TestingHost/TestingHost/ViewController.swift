//
//  ViewController.swift
//  TestingHost
//
//  Created by Kyle on 2025/2/17.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#else
#error("Unsupported platform")
#endif
import CaptureHider

#if canImport(UIKit)
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.hideViewFromCapture(hide: true)
    }
}
#else
class ViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.red.cgColor
        view.hideViewFromCapture(hide: true)
    }
}
#endif
