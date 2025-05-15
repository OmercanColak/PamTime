//
//  ContentView.swift
//  PamTime
//
//  Created by Ömercan Çolak on 14.05.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var tabRouter: TabRouter
    
    
    @AppStorage("selectedTheme") private var selectedTheme: String = ThemeMode.system.rawValue
    var body: some View {
        TabView(selection: $tabRouter.currentTab) {
            WorkTimerView()
                .tabItem {
                    Label("Çalış", systemImage: TimerMode.work.icon)
                }
                .tag(TimerMode.work)

            ShortBreakView()
                .tabItem {
                    Label("Kısa Mola", systemImage: TimerMode.shortBreak.icon)
                }
                .tag(TimerMode.shortBreak)

            LongBreakView()
                .tabItem {
                    Label("Uzun Mola", systemImage: TimerMode.longBreak.icon)
                }
                .tag(TimerMode.longBreak)
            
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

