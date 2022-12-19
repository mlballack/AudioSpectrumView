//
//  RecordButton.swift
//  AudioRecordUI
//
//  Created by 林 政樹 on 2022/12/07.
//

import SwiftUI

struct RecordButton: View {
    
    @State var isRecording: Bool = false
    var actionHandler: (() -> Void)? = nil
    
    var body: some View {
        Circle()
            .stroke(Color(UIColor.gray.cgColor), lineWidth: 3.0)
            .frame(width: 60, height: 60)
            .overlay {
                Button {
                    self.actionHandler?()
                    withAnimation(.linear(duration: 0.2)) {
                        isRecording.toggle()
                    }
                    
                } label: {
                    let size:CGFloat = isRecording ? 25 : 50
                    RoundedRectangle(cornerRadius: isRecording ? 5 : 75)
                        .fill(Color.red)
                        .frame(width: size, height: size, alignment: .center)
                }
            }
    }
}

struct RecordButton_Previews: PreviewProvider {
    
    static var previews: some View {
        RecordButton()
    }
}

