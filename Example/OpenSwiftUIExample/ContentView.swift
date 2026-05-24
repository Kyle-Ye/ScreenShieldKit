//
//  ContentView.swift
//  OpenSwiftUIExample
//
//  Created by Kyle on 2026/05/24.
//

import OpenSwiftUI
import ScreenShieldKit

struct ContentView: View {
    @State private var hideProtectedContent = false

    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()

            Color.blue
                .ignoresSafeArea()
                .hiddenFromCapture(hideProtectedContent)

            Toggle(isOn: $hideProtectedContent) {
                Text(verbatim: "")
            }
            .labelsHidden()
            .hiddenFromCapture()
        }
    }
}
