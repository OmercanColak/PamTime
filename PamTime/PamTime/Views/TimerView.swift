//  TimerView.swift
//  PamTime
//
//  Created by Ömercan Çolak on 14.05.2025.

import SwiftUI

struct TimerView: View {
    let mode: TimerMode
    @StateObject private var viewModel: TimerViewModel
    @State private var animateIcon = false
    @EnvironmentObject var tabRouter: TabRouter
    @State private var showBreakChoice = false

    init(mode: TimerMode) {
        self.mode = mode
        switch mode {
        case .work:
            _viewModel = StateObject(wrappedValue: TimerViewModel(mode: mode, defaultMinutes: 25))
        case .shortBreak:
            _viewModel = StateObject(wrappedValue: TimerViewModel(mode: mode, defaultMinutes: 5))
        case .longBreak:
            _viewModel = StateObject(wrappedValue: TimerViewModel(mode: mode, defaultMinutes: 15))
        case .theme:
                _viewModel = StateObject(wrappedValue: TimerViewModel(mode: mode, defaultMinutes: 0))
        }
    }

    var body: some View {
        ZStack {
            mode.gradient
                .ignoresSafeArea()
                .blur(radius: 80)

            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Image(systemName: mode.animatedIcon)
                        .font(.system(size: 48))
                        .foregroundColor(.white)
                        .scaleEffect(animateIcon ? 1.1 : 0.9)
                        .shadow(radius: 10)
                        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animateIcon)

                    Text(mode.label)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                }

                Picker("Süre", selection: $viewModel.selectedMinutes) {
                    ForEach(1...60, id: \..self) { minute in
                        Text("\(minute) dakika").tag(minute)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 100)
                .disabled(viewModel.isRunning)

                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 20)

                    Circle()
                        .trim(from: 0, to: viewModel.progress())
                        .stroke(viewModel.alarmPlayed ? (viewModel.flash ? Color.red : Color.clear) : mode.color,
                                style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .rotationEffect(.degrees(-90))

                    Text(viewModel.timeText())
                        .font(.system(size: 60, weight: .medium, design: .monospaced))
                        .padding()
                }
                .frame(width: 250, height: 250)

                HStack(spacing: 30) {
                    Button(viewModel.isRunning ? "Duraklat" : "Başlat") {
                        if viewModel.isConfigured {
                            viewModel.toggle()
                        } else {
                            viewModel.start()
                        }
                    }
                    .padding()
                    .frame(width: 100)
                    .background(mode.color)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("Sıfırla") {
                        viewModel.reset()
                    }
                    .padding()
                    .frame(width: 100)
                    .background(Color.red.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
            .onAppear {
                animateIcon = true
            }
            .onReceive(viewModel.$didFinish) { finished in
                if finished && mode == .work {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5 ) {
                        showBreakChoice = true
                    }
                    viewModel.didFinish = false
                }
            }
            .alert("Mola Zamanı!", isPresented: $showBreakChoice) {
                Button("Kısa Mola") {
                    tabRouter.currentTab = .shortBreak
                }
                Button("Uzun Mola") {
                    tabRouter.currentTab = .longBreak
                }
                Button("İptal", role: .cancel) { }
            } message: {
                Text("Hangi Molaya Geçmek istersiniz?")
            }
        }
    }
}
