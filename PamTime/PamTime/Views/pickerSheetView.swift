//
//  PickerSheetView.swift
//  PamTime
//
//  Created by Ömercan Çolak on 13.05.2025.
//

import SwiftUI

struct PickerSheetView: View {
    @Binding var selectedMinutes: Int
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Dakika Seç")
                .font(.headline)
                .padding(.top)

            Picker("Süre", selection: $selectedMinutes) {
                ForEach(1...60, id: \.self) {
                    Text("\($0) dakika").tag($0)
                }
            }
            .labelsHidden()
            .pickerStyle(.wheel)
            .frame(height: 150)

            Button("Tamam") {
                isPresented = false
            }
            .font(.headline)
            .foregroundColor(.blue)
            .padding(.bottom)
        }
        .padding(.horizontal)
    }
}

#Preview {
    PickerSheetView(selectedMinutes: .constant(25), isPresented: .constant(true))
}
