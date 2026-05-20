//
//  ScreenshotAssertions.swift
//  ScreenShieldKitExamples
//
//  Created by Kyle on 2026/05/20.
//

import UIKit
import XCTest

extension XCTestCase {
    @MainActor
    func assertScreenshot(
        color: UIColor,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let image = XCUIScreen.main.screenshot().image
        XCTAssertTrue(
            image.matchesSolidColor(color),
            "Expected screenshot to be solid \(color), got sampled colors \(image.sampledColorsDescription)",
            file: file,
            line: line
        )
    }
}

private extension UIImage {
    var sampledColorsDescription: String {
        samplePoints
            .map { point in
                color(at: point).map(String.init(describing:)) ?? "nil"
            }
            .joined(separator: ", ")
    }

    func matchesSolidColor(_ color: UIColor, tolerance: CGFloat = 1.0 / 255.0) -> Bool {
        samplePoints.allSatisfy { point in
            guard let sampledColor = self.color(at: point) else {
                return false
            }
            return sampledColor.matches(color, tolerance: tolerance)
        }
    }

    private var samplePoints: [CGPoint] {
        let inset: CGFloat = 12
        return [
            CGPoint(x: size.width * 0.5, y: size.height * 0.5),
            CGPoint(x: inset, y: inset),
            CGPoint(x: size.width - inset, y: inset),
            CGPoint(x: inset, y: size.height - inset),
            CGPoint(x: size.width - inset, y: size.height - inset),
        ]
    }

    private func color(at point: CGPoint) -> UIColor? {
        guard let cgImage else {
            return nil
        }
        let scaleX = CGFloat(cgImage.width) / size.width
        let scaleY = CGFloat(cgImage.height) / size.height
        let x = min(max(Int(point.x * scaleX), 0), cgImage.width - 1)
        let y = min(max(Int(point.y * scaleY), 0), cgImage.height - 1)
        var pixel: [UInt8] = [0, 0, 0, 0]
        guard let context = CGContext(
            data: &pixel,
            width: 1,
            height: 1,
            bitsPerComponent: 8,
            bytesPerRow: 4,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return nil
        }
        context.translateBy(x: CGFloat(-x), y: CGFloat(y - cgImage.height + 1))
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height))
        return UIColor(
            red: CGFloat(pixel[0]) / 255.0,
            green: CGFloat(pixel[1]) / 255.0,
            blue: CGFloat(pixel[2]) / 255.0,
            alpha: CGFloat(pixel[3]) / 255.0
        )
    }
}

private extension UIColor {
    func matches(_ other: UIColor, tolerance: CGFloat) -> Bool {
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0
        getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        other.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        return abs(r1 - r2) <= tolerance
            && abs(g1 - g2) <= tolerance
            && abs(b1 - b2) <= tolerance
            && abs(a1 - a2) <= tolerance
    }
}
