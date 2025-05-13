//
//  TimerModel.swift
//  PamTime
//
//  Created by Ömercan Çolak on 13.05.2025.
//
import Foundation

struct TimerModel {
    var selectedMinutes: Int
    var timeRemaining: Int {
        selectedMinutes * 60
    }
}
