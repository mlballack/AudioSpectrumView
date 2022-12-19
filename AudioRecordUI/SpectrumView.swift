//
//  SpectrumView.swift
//  AudioRecordUI
//
//  Created by 林 政樹 on 2022/12/07.
//

import SwiftUI

struct SpectrumView: View {
    @State var levelArray: [CGFloat] = []
    @Binding var value: CGFloat

    private let interval:CGFloat = 5.0
    
    var body: some View {
        GeometryReader { render in
            Path { path in
                let y_0 = render.size.height * 0.5
                var x = 0.0
                
                for level in levelArray {
                    path.move(
                        to: .init(
                            x: x,
                            y: (1 - level) * y_0
                        )
                    )
                    path.addLine(
                        to: .init(
                            x: x,
                            y: (1 + level) * y_0
                        )
                    )
                    
                    x += interval
                }
            }
            .stroke(lineWidth: 1.0)
            .fill(Color.red)
            .onChange(of: value, perform: { newValue in
                if levelArray.isEmpty { return }
                levelArray.append(newValue)
                levelArray.remove(at: 0)
            })
            .onAppear {
                if levelArray.isEmpty == false { return }
                let count = render.size.width / interval
                levelArray = Array(repeating: 0.01, count: Int(count))
            }
        }
    }
}
