//
//  AppDelegate.swift
//  AppKitExample
//
//  Created by Kyle on 2026/05/13.
//

import AppKit
import ScreenShieldKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var window: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)

        let contentView = ShieldDemoView(frame: NSRect(x: 0, y: 0, width: 640, height: 420))
        let window = NSWindow(
            contentRect: contentView.bounds,
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.title = "AppKitExample"
        window.contentView = contentView
        window.center()
        window.makeKeyAndOrderFront(nil)
        window.orderFrontRegardless()
        NSApp.activate(ignoringOtherApps: true)
        self.window = window
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}

private final class ShieldDemoView: NSView {
    private let protectedView = NSView()
    private let toggle = NSButton(checkboxWithTitle: "Hide from capture", target: nil, action: nil)

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.backgroundColor = NSColor.systemRed.cgColor

        protectedView.wantsLayer = true
        protectedView.layer?.backgroundColor = NSColor.systemBlue.cgColor
        addSubview(protectedView)

        toggle.wantsLayer = true
        toggle.target = self
        toggle.action = #selector(toggleChanged(_:))
        toggle.bezelStyle = .rounded
        toggle.hiddenFromCapture()
        addSubview(toggle)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    override func layout() {
        super.layout()
        protectedView.frame = bounds
        toggle.sizeToFit()
        toggle.frame.origin = NSPoint(x: 24, y: 24)
    }

    @objc
    private func toggleChanged(_ sender: NSButton) {
        protectedView.hiddenFromCapture(sender.state == .on)
    }
}
