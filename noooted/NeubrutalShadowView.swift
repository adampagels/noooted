//
//  NeubrutalShadowView.swift
//  noooted
//
//  Created by Adam Pagels on 2024-01-17.
//

import SwiftUI

struct NeubrutalShadowView<T: View>: View {
    let content: T
    let shape: String
    let contentColor: Color
    
    init(shape: String, contentColor: Color, @ViewBuilder content: () -> T) {
        self.content = content()
        self.shape = shape
        self.contentColor = contentColor
    }
    
    var body: some View {
        ZStack {
            if (shape == "rectangle") {
                RoundedRectangle(cornerRadius: 8)
                    .offset(x: 3, y: 5)
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(contentColor)
                content
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            } else {
                Circle()
                    .offset(x: 1.5, y: 2)
                    .fill(Color.black)
                Circle()
                    .offset(x: 1.5, y: 2)
                    .fill(Color.black)
                content
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
            }
        }
    }
}

struct NeubrutalShadowView_Previews: PreviewProvider {
    static var previews: some View {
        NeubrutalShadowView(shape: "rectangle", contentColor: .white) {
            Text("Hello, NeubrutalShadowView!")
        }
    }
}
