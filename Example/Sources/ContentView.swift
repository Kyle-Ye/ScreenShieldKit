//
//  ContentView.swift
//  ScreenShieldKitExample
//
//  Created by Kyle on 2026/05/12.
//

import ScreenShieldKit
import SwiftUI

struct ContentView: View {
    @State private var hideProtectedContent = false

    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()

            Color.blue
                .ignoresSafeArea()
                .hiddenFromCapture(hideProtectedContent)

            VStack {
                Spacer()

                Toggle("Hide from capture", isOn: $hideProtectedContent)
                    .labelsHidden()
                    .accessibilityIdentifier("capture-toggle")
                    .padding(24)
                    .hiddenFromCapture()
            }
        }
    }
}
