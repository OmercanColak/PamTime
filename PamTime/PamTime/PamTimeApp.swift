//
//  PamTimeApp.swift
//  PamTime
//
//  Created by Ömercan Çolak on 15.04.2025.
//

import SwiftUI

@main
struct PamTimeApp: App {
    @StateObject var tabRouter = TabRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tabRouter)
        }
    }
}
