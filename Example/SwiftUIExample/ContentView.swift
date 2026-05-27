//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by Kyle on 2026/05/12.
//

import ScreenShieldKit
import SwiftUI

struct ContentView: View {
    @State private var hideProtectedContent = false

    var body: some View {
        ZStack {
            Color(platformColor: .red)
                .ignoresSafeArea()

            Color(platformColor: .blue)
                .ignoresSafeArea()
                .hiddenFromCapture(hideProtectedContent)

            Toggle("", isOn: $hideProtectedContent)
                .labelsHidden()
                .accessibilityIdentifier("captureToggle")
                .hiddenFromCapture()
        }
        .persistentSystemOverlays(.hidden)
    }
}

#if canImport(UIKit)
import UIKit
typealias PlatformColor = UIColor
#elseif canImport(AppKit)
import AppKit
typealias PlatformColor = NSColor
#endif

private extension Color {
    init(platformColor: PlatformColor) {
        #if canImport(UIKit)
        self.init(uiColor: platformColor)
        #elseif canImport(AppKit)
        self.init(nsColor: platformColor)
        #endif
    }
}
