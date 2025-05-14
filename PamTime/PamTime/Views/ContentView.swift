//
//  ContentView.swift
//  PamTime
//
//  Created by Ömercan Çolak on 14.05.2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTheme") private var selectedTheme: String = ThemeMode.system.rawValue
    var body: some View {
        TabView {
            WorkTimerView()
                .tabItem {
                    Label("Çalış", systemImage: TimerMode.work.icon)
                }

            ShortBreakView()
                .tabItem {
                    Label("Kısa Mola", systemImage: TimerMode.shortBreak.icon)
                }

            LongBreakView()
                .tabItem {
                    Label("Uzun Mola", systemImage: TimerMode.longBreak.icon)
                }
            
            ThemeSettingsView()
                .tabItem {
                    Label("Tema", systemImage: "paintpalette")
                }
        }
        .preferredColorScheme(currentTheme.colorScheme)
    }
    var currentTheme: ThemeMode {
        ThemeMode(rawValue: selectedTheme) ?? .system
    }
}

