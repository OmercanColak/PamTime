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
    @Published var selectedMinutes: Int = 25
    @Published var timeRemaining: Int = 1500
    @Published var timerIsRunning: Bool = false
    @Published var timerConfigured: Bool = false
    @Published var flash: Bool = false
    @Published var alarmPlayed: Bool = false
    
    private var player: AVAudioPlayer?
    private var timer: Timer?
    
    func startTimer() {
        timeRemaining = selectedMinutes * 60
        timerConfigured = true
        timerIsRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.tick()
        }
    }
    func tick() {
        guard timerIsRunning else { return }
        
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timerIsRunning = false
            playSound()
            startFlashing()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    self.reset()
                }
            }
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
        timeRemaining = selectedMinutes * 60
        flash = false
        alarmPlayed = false
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
    
    func progressValue() -> CGFloat {
        let total = selectedMinutes * 60
        return 1 - CGFloat(timeRemaining) / CGFloat(total)
    }
    
    func formatTime() -> String {
        String(format: "%02d:%02d", timeRemaining / 60, timeRemaining % 60)
    }
}
