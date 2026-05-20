//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by Kyle on 2026/05/12.
//

import ScreenShieldKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            Color.blue
                .ignoresSafeArea()
                .hiddenFromCapture(true)
        }
        .persistentSystemOverlays(.hidden)
    }
}
