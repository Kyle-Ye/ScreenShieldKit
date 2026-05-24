//
//  ContentView.swift
//  OpenSwiftUIExample
//
//  Created by Kyle on 2026/05/24.
//

import Foundation
import OpenSwiftUI
import ScreenShieldKit

struct ContentView: View {
    @State private var hideProtectedContent: Bool

    init() {
        _hideProtectedContent = State(initialValue: ProcessInfo.processInfo.arguments.contains("--hide-protected-content"))
    }

    var body: some View {
        ZStack {
            Color(platformColor: .red)
                .ignoresSafeArea()

            Color(platformColor: .blue)
                .ignoresSafeArea()
                .hiddenFromCapture(hideProtectedContent)

            // FIXME: Toggle render position issue and gesture support
            Toggle(isOn: $hideProtectedContent) {
                Text(verbatim: "")
            }
            .labelsHidden()
            .hiddenFromCapture()
        }
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
