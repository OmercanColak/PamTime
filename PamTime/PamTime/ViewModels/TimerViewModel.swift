//
//  TimerViewModel.swift
//  PamTime
//
//  Created by Ömercan Çolak on 13.05.2025.
//
import Foundation
import AVFoundation
import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var selectedWorkMinutes: Int = 25
    @Published var shortBreakDuration: Int = 5
    @Published var longBreakDuration: Int = 15

    @Published var timeRemaining: Int = 25 * 60
    @Published var timerIsRunning: Bool = false
    @Published var timerConfigured: Bool = false
    @Published var flash: Bool = false
    @Published var alarmPlayed: Bool = false
    @Published var mode: TimerMode = .work
    @Published var pomodoroCount: Int = 0

    private var player: AVAudioPlayer?
    private var timer: Timer?

    // MARK: - Public Methods

    func modeLabel() -> String {
        switch mode {
        case .work: return "Çalışma Süresi"
        case .shortBreak: return "Kısa Mola"
        case .longBreak: return "Uzun Mola"
        }
    }

    func startTimer() {
        switch mode {
        case .work:
            timeRemaining = selectedWorkMinutes * 60
        case .shortBreak:
            timeRemaining = shortBreakDuration * 60
        case .longBreak:
            timeRemaining = longBreakDuration * 60
        }

        timerIsRunning = true
        timerConfigured = true

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.tick()
        }
    }

    func toggleTimer() {
        timerIsRunning.toggle()
    }

    func reset() {
        timer?.invalidate()
        timer = nil
        timerIsRunning = false
        timerConfigured = false
        flash = false
        alarmPlayed = false
        mode = .work
    }

    func formatTime() -> String {
        String(format: "%02d:%02d", timeRemaining / 60, timeRemaining % 60)
    }

    func progressValue() -> CGFloat {
        let total: Int
        switch mode {
        case .work:
            total = selectedWorkMinutes * 60
        case .shortBreak:
            total = shortBreakDuration * 60
        case .longBreak:
            total = longBreakDuration * 60
        }
        return 1 - CGFloat(timeRemaining) / CGFloat(total)
    }

    // MARK: - Private Helpers

    private func tick() {
        guard timerIsRunning else { return }

        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timerIsRunning = false
            playSound()
            startFlashing()

            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    self.flash = false
                    self.alarmPlayed = false
                    self.timerConfigured = false

                    // Mod geçişi:
                    switch self.mode {
                    case .work:
                        self.pomodoroCount += 1
                        self.mode = (self.pomodoroCount % 4 == 0) ? .longBreak : .shortBreak
                    case .shortBreak, .longBreak:
                        self.mode = .work
                    }
                }
            }
        }
    }

    private func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "wav") else {
            print("Ses dosyası bulunamadı.")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Ses çalınamadı: \(error.localizedDescription)")
        }
    }

    private func startFlashing() {
        alarmPlayed = true
        withAnimation(Animation.easeOut(duration: 0.5).repeatForever(autoreverses: true)) {
            flash = true
        }
    }
}
