//
//  ThemeMode.swift
//  PamTime
//
//  Created by Ömercan Çolak on 14.05.2025.
//

import Foundation
import SwiftUI

enum ThemeMode: String, CaseIterable, Identifiable {
    case system, light, dark
    
    var id: String { self.rawValue }
    var label: String {
        switch self {
        case .system: return "System"
        case .light: return "Açık"
        case .dark: return "Koyu"
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}
