//
//  TimerViewModel.swift
//  PamTime
//
//  Created by Ömercan Çolak on 13.05.2025.
//
// TimerViewModel.swift
// ViewModels folder

import Foundation
import SwiftUI
import AVFoundation

class TimerViewModel: ObservableObject {
    @Published var selectedMinutes: Int {
        didSet {
            if !isRunning && !isConfigured {
                timeRemaining = selectedMinutes * 60
            }
        }
    }
    @Published var timeRemaining: Int
    @Published var isRunning: Bool = false
    @Published var isConfigured: Bool = false
    @Published var flash: Bool = false
    @Published var alarmPlayed: Bool = false
    @Published var didFinish: Bool = false

    let mode: TimerMode
    private var timer: Timer?
    private var player: AVAudioPlayer?
    private var startDate: Date?

    init(mode: TimerMode, defaultMinutes: Int) {
        self.mode = mode
        self.selectedMinutes = defaultMinutes
        self.timeRemaining = defaultMinutes * 60
    }

    func start() {
        timer?.invalidate()
        timer = nil
        
        timeRemaining = selectedMinutes * 60
        startDate = Date()
        isRunning = true
        isConfigured = true

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateTime()
        }
    }
    private func updateTime() {
        guard let start = startDate else { return }
        
        let elapsed = Int(Date().timeIntervalSince(start))
        let total = selectedMinutes * 60
        
        timeRemaining = max(total - elapsed, 0)
        
        if timeRemaining == 0 {
            timer?.invalidate()
            timer = nil
            isRunning = false
            playSound()
            sendNotification()
            startFlashing()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    self.flash = false
                    self.alarmPlayed = false
                    self.isConfigured = false
                    self.timeRemaining = self.selectedMinutes * 60
                }
            }
            self.didFinish = true
        }
    }
    func toggle() {
        isRunning.toggle()
    }

    func reset() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        isConfigured = false
        flash = false
        alarmPlayed = false
        timeRemaining = selectedMinutes * 60
    }

    private func tick() {
        guard isRunning else { return }

        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            isRunning = false
            playSound()
            startFlashing()

            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    self.flash = false
                    self.alarmPlayed = false
                    self.isConfigured = false
                    self.timeRemaining = self.selectedMinutes * 60
                }
            }
        }
    }

    func progress() -> CGFloat {
        return 1 - CGFloat(timeRemaining) / CGFloat(selectedMinutes * 60)
    }

    func timeText() -> String {
        String(format: "%02d:%02d", timeRemaining / 60, timeRemaining % 60)
    }

    private func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "wav") else {
            print("Alarm sesi bulunamadı")
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
    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Süre Doldu!"
        content.body = "🎯 Pomodoro tamamlandı. Şimdi mola zamanı!"
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification Center Error: \(error.localizedDescription)")
            }
        }
    }
}
