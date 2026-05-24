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

#if os(iOS) || os(tvOS) || os(visionOS)
typealias PlatformColor = UIColor
#elseif os(macOS)
typealias PlatformColor = NSColor
#endif

private extension Color {
    init(platformColor: PlatformColor) {
        #if os(iOS) || os(tvOS) || os(visionOS)
        self.init(uiColor: platformColor)
        #elseif os(macOS)
        self.init(nsColor: platformColor)
        #endif
    }
}
