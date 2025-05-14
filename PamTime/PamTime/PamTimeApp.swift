//
//  PamTimeApp.swift
//  PamTime
//
//  Created by Ömercan Çolak on 15.04.2025.
//

import SwiftUI

@main
struct PamTimeApp: App {
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                TimerView()
                    .tabItem {
                        Label("Zamanlayıcı", systemImage: "timer")
                    }
                SettingsView()
                    .tabItem {
                        Label("Ayarlar", systemImage: "gear")
                    }
                }
            .environmentObject(viewModel)
        }
    }
}
