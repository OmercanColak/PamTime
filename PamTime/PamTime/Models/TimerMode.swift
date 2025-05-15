//
//  TimerModel.swift
//  PamTime
//
//  Created by Ömercan Çolak on 13.05.2025.
//
import SwiftUI

enum TimerMode {
    case work, shortBreak, longBreak, theme
    
    var label: String {
        switch self {
        case .work: return "Çalışma Süresi"
        case .shortBreak: return "Kısa Mola"
        case .longBreak: return "Uzun Mola"
        case .theme: return "Tema"
        }
    }
    
    var color: Color {
        switch self {
        case .work: return .green
        case .shortBreak: return .blue
        case .longBreak: return .orange
        case .theme: return .purple
        }
    }
    
    var icon: String {
        switch self {
        case .work: return "hammer.fill"
        case .shortBreak: return "cup.and.saucer.fill"
        case .longBreak: return "bed.double.fill"
        case .theme: return "paintpalette"
        }
    }
    var gradient: LinearGradient {
        switch self {
        case .work:
            return LinearGradient(colors: [.green.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .shortBreak:
            return LinearGradient(colors: [.blue.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .longBreak:
            return LinearGradient(colors: [.orange.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .theme:
                return LinearGradient(colors: [.purple.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
    var animatedIcon: String {
        switch self {
        case .work: return "hammer.fill"
        case .shortBreak: return "cup.and.saucer.fill"
        case .longBreak: return "bed.double.fill"
        case .theme: return "paintpalette.fill"
        }
    }
}
