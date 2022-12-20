//
//  ContentView.swift
//  AudioRecordUI
//
//  Created by 林 政樹 on 2022/12/07.
//

import SwiftUI

struct ContentView: View {
    let groupedBgColor: Color = Color(cgColor: UIColor.systemGroupedBackground.cgColor)
    
    @State var isRecording = false
    @State var value: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                SpectrumView(value: $value)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: 200
                    )
                Spacer()
                RecordButton {
                    Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { timer in
                        if isRecording == false {
                            timer.invalidate()
                            return
                        }
                        value = CGFloat.random(in: 0.01...0.5)
                    }
                    isRecording.toggle()
                }
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
