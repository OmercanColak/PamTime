//
//  LaunchScreen.swift
//  PamTime
//
//  Created by Ömercan Çolak on 15.05.2025.
//
import SwiftUI

struct LaunchScreenUI: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.green.opacity(0.6), .indigo.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Image("AppLogo")
                    .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .shadow(radius: 10)

                Text("PamTime")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    LaunchScreenUI()
}
