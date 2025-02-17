//
//  CaptureHider.swift
//  CaptureHider
//
//  Created by Kyle on 2025/02/17.
//  Creadit: https://nsantoine.dev/posts/CALayerCaptureHiding

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#else
#error("Unsupported platform")
#endif
import os.log

let logger = OSLog(subsystem: "top.kyleye.capturehider", category: "CaptureHider")

extension CALayer {
    // hides view/layer when:
    // 1) a screenshot is taken
    // 2) a screen recording is happening
    // the screen recording can either be on-device, like from the Control Center
    // or can be from another source, like recording the screen from a mac on QuickTime
    @discardableResult
    public func hideViewFromCapture(hide: Bool) -> Bool {
        #if targetEnvironment(simulator)
        os_log(.info, log: logger, "Not supported on Simulator environment")
        return false
        #else
        let propertyBase64 = "ZGlzYWJsZVVwZGF0ZU1hc2s=" /* "disableUpdateMask" encoded in base64 */
        guard let propertyData = Data(base64Encoded: propertyBase64),
              let propertyString = String(data: propertyData, encoding: .utf8) else {
            os_log(.error, log: logger, "Couldn't decode property string")
            return false
        }
        guard responds(to: NSSelectorFromString(propertyString)) else {
            os_log(.error, log: logger, "CALayer does not response to selector %@", propertyString)
            return false
        }
        if hide {
            let hideFlag = (1 << 1) | (1 << 4)
            setValue(NSNumber(value: hideFlag), forKey: propertyString)
        } else {
            setValue(NSNumber(value: 0), forKey: propertyString)
        }
        return true
        #endif
    }
}

#if canImport(UIKit)
extension UIView {
    @discardableResult
    public func hideViewFromCapture(hide: Bool = true) -> Bool {
        layer.hideViewFromCapture(hide: hide)
    }
}
#elseif canImport(AppKit)
extension NSView {
    // FIXME: Not work for macOS currently
    @discardableResult
    public func hideViewFromCapture(hide: Bool = true) -> Bool {
        guard let layer else {
            os_log(.error, log: logger, "NSView is not backed by CALayer")
            return false
        }
        return layer.hideViewFromCapture(hide: hide)
    }
}
#endif
