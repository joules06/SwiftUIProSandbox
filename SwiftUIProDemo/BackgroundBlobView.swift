//
//  BackgroundBlobView.swift
//  SwiftUIProDemo
//
//  Created by Julio Rico on 19/9/22.
//

import SwiftUI
struct BackroundBlurBlobView: View {
    @State private var rotatioAmount = 0.0
    let aligment: Alignment = [.topLeading, .topTrailing, .bottomLeading, .bottomTrailing].randomElement()!
    let color: Color = [.blue, .blue, .blue, .cyan, .indigo, .mint, .orange, .pink, .purple, .red, .teal, .yellow].randomElement()!
    
    var body: some View {
        Ellipse()
            .fill(color)
            .frame(width: .random(in: 200...500), height: .random(in: 200...500))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: aligment)
            .offset(x: .random(in: -400...400), y: .random(in: -400...400))
            .rotationEffect(.degrees(rotatioAmount))
            .animation(.linear(duration: .random(in: 2...4)).repeatForever(), value: rotatioAmount)
            .onAppear {
                rotatioAmount = .random(in: -360...360)
            }
            .blur(radius: 75)
    }
}

struct BackgroundBlobView: View {
    var body: some View {
        ZStack {
            ForEach(0..<15) { _ in
                BackroundBlurBlobView()
            }
        }
        .background(.blue)
    }
}

struct BackgroundBlobView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundBlobView()
    }
}
