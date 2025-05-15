//
//  ThemeSettingsView.swift
//  PamTime
//
//  Created by Ömercan Çolak on 14.05.2025.
//
import SwiftUI

struct ThemeSettingsView: View {
    @EnvironmentObject var tabRouter: TabRouter
    
    @AppStorage("selectedTheme") private var selectedTheme: String = ThemeMode.system.rawValue
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Tema")) {
                    Picker("Tema", selection: $selectedTheme) {
                        ForEach(ThemeMode.allCases) { mode in
                            Text(mode.label).tag(mode.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Görünüm")
        }
    }
}
