//
//  ContentView.swift
//  PamTime
//
//  Created by Ömercan Çolak on 15.04.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TimerViewModel()
    @State private var showPickerSheet = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Pomodoro Timer")
                .font(.largeTitle)
                .bold()
            
            if !viewModel.timerConfigured {
                Button(action: {
                    showPickerSheet = true
                }) {
                    Text("Süre Seçiniz: \(viewModel.selectedMinutes) dakika")
                        .font(.title2)
                }
                .sheet(isPresented: $showPickerSheet) {
                    PickerSheetView(selectedMinutes: $viewModel.selectedMinutes, isPresented: $showPickerSheet)
                        .presentationDetents([.height(285)])
                        .presentationDragIndicator(.visible)
                }
            } else {
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                    
                    Circle()
                        .trim(from: 0, to: viewModel.progressValue())
                        .stroke(viewModel.alarmPlayed ? (viewModel.flash ? Color.red : Color.clear) : Color.green,
                                style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    
                    Text(viewModel.formatTime())
                        .font(.system(size: 64, weight: .medium, design: .monospaced))
                        .padding()
                }
                .frame(width: 250, height: 250)
                
                HStack(spacing: 40) {
                    Button(viewModel.timerIsRunning ? "Duraklat" : "Devam Et") {
                        viewModel.toggleTimer()
                    }
                    .font(.title2)
                    .frame(width: 100, height: 50)
                    .background(Color.green.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Sıfırla") {
                        viewModel.reset()
                    }
                    .font(.title2)
                    .frame(width: 100, height: 50)
                    .background(Color.red.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
