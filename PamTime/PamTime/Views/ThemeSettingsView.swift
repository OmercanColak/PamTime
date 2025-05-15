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
                    
                    
                    Button(action: {
                        if let url = URL(string: "https://docs.google.com/document/d/1_W9QMOA9837aiskh75lZYtGU8_rUjkZju8_UgWLntr8/edit?usp=sharing") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("Gizlilik Politikası")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .underline()
                    }
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Görünüm")
        }
    }
}
