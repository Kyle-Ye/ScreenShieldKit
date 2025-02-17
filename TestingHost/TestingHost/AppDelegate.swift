//
//  AppDelegate.swift
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

#if canImport(UIKit)
@main
class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
#else
//@main
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow?

    override init() {
        self.window = nil
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
    }
}
#endif

