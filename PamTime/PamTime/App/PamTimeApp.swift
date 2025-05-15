//
//  PamTimeApp.swift
//  PamTime
//
//  Created by Ömercan Çolak on 15.04.2025.
//

import SwiftUI
import UserNotifications

@main
struct PamTimeApp: App {
    @StateObject var tabRouter = TabRouter()
    init() {
        requestNotificationPermissions()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tabRouter)
        }
    }
}

func requestNotificationPermissions() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
        if let error = error {
            print("Bildirim izni hatası: \(error.localizedDescription)")
        }else {
            print("Bildirim izni verildi mi \(granted)")
        }
    }
}
