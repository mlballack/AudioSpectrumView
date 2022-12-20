//
//  RecordUI.swift
//  AudioRecordUI
//
//  Created by Masaki on 2022/12/20.
//

import Foundation
import SwiftUI

struct RecordUI: View {
    let groupedBgColor: Color = Color(cgColor: UIColor.systemGroupedBackground.cgColor)
    
    @State var isRecording = false
    @State var value: CGFloat = 0.0
    @State var timeText: String = "00:00:00"
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    if isRecording {
                        VStack(spacing: 10) {
                            Spacer()
                            Text("タイトル１")
                                .font(.system(size: 22, weight: .bold))
                            
                            Text(timeText)
                                .foregroundColor(Color(cgColor: UIColor.darkGray.cgColor))
                                .font(.system(size: 15).monospacedDigit())
                                .frame(alignment: .center)
                            
                            SpectrumView(value: $value)
                        }
                    }
                    
                    RecordButton {
                        let startTime = Date.now
                        Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { timer in
                            if isRecording == false {
                                timer.invalidate()
                                return
                            }
                            
                            let duration = timer.fireDate.timeIntervalSince(startTime)
                            print(duration)
                            
                            timeText = getTimeString(interval: duration)
                            value = CGFloat.random(in: 0.01...0.5)
                        }
                        withAnimation(.linear(duration: 0.2)) {
                            isRecording.toggle()
                        }
                    }
                    Spacer()
                    .frame(maxWidth: .infinity, maxHeight: 40)
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: isRecording ? 320 : 120,
                    alignment: .bottom
                )
                .background(groupedBgColor)
                .cornerRadius(isRecording ? 10 : 0, corners: [.topLeft, .topRight])
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(.white)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func getTimeString(interval: TimeInterval) -> String {
        let time = Int(interval)
        let h = time / 3600 % 24
        let m = time / 60 % 60
        let s = time % 60
        let ms = Int(interval*100) % 100
        
        if h > 0 {
            return String(format: "%02d:%02d:%02d.%02d", h,m,s,ms)
        }
        return String(format: "%02d:%02d.%02d", m,s,ms)
    }
}
