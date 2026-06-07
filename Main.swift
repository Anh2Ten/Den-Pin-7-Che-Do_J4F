//
//  Main.swift
//  Đèn Pin 7 Chế Độ
//
//  Created by leanh on 6/6/26.
//
import SwiftUI
import UIKit

struct ContentView: View {

    @State private var vibrationEnabled = false
    @State private var vibrationStrength: Double = 0.5

    @State private var vibrationTimer: Timer?

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {

                Toggle("Bật rung liên tục", isOn: $vibrationEnabled)
                    .padding(.horizontal)
                    .onChange(of: vibrationEnabled) { _, enabled in
                        if enabled {
                            startVibration()
                        } else {
                            stopVibration()
                        }
                    }

                VStack(alignment: .leading, spacing: 12) {

                    Text("Độ mạnh rung: \(Int(vibrationStrength * 100))%")
                        .font(.headline)

                    Slider(
                        value: $vibrationStrength,
                        in: 0.0...1.0
                    )
                }
                .padding(.horizontal)

                Text(vibrationEnabled ? "Đang rung..." : "Đã dừng")
                    .font(.title3)
                    .foregroundStyle(vibrationEnabled ? .green : .secondary)

                Spacer()

                Text("Made by Anh2Ten")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 10)
            }
            .navigationTitle("Đèn Pin 7 Chế Độ")
            .onDisappear {
                stopVibration()
            }
        }
    }

    private func startVibration() {

        stopVibration()

        vibrationTimer = Timer.scheduledTimer(
            withTimeInterval: 0.15,
            repeats: true
        ) { _ in

            let style: UIImpactFeedbackGenerator.FeedbackStyle

            switch vibrationStrength {
            case 0..<0.2:
                style = .soft
            case 0.2..<0.4:
                style = .light
            case 0.4..<0.7:
                style = .medium
            case 0.7..<0.9:
                style = .rigid
            default:
                style = .heavy
            }

            let generator = UIImpactFeedbackGenerator(style: style)
            generator.prepare()

            generator.impactOccurred(
                intensity: CGFloat(max(0.1, vibrationStrength))
            )
        }
    }

    private func stopVibration() {
        vibrationTimer?.invalidate()
        vibrationTimer = nil
    }
}

#Preview {
    ContentView()
}
