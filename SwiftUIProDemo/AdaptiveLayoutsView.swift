//
//  AdaptiveLayoutsView.swift
//  SwiftUIProDemo
//
//  Created by Julio Rico on 13/9/22.
//

import SwiftUI

struct ExampleLayoutView: View {
    @State private var counter = 0
    let color: Color
    
    var body: some View {
        Button {
            counter += 1
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .overlay(
                    Text(String(counter))
                        .foregroundColor(.white)
                        .font(.largeTitle)
                )
        }
        .frame(width: 100, height: 100)
        .rotationEffect(.degrees(.random(in: -20...20)))
    }
}

struct RadialLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let radious = min(bounds.size.width, bounds.size.height) / 2
        let angle = Angle.degrees(360 / Double(subviews.count)).radians
        
        for (index, subview) in subviews.enumerated() {
            let viewSize = subview.sizeThatFits(.unspecified)
            let xPos = cos(angle * Double(index) - .pi / 2) * (radious - viewSize.width / 2)
            let yPos = sin(angle * Double(index) - .pi / 2) * (radious - viewSize.height / 2)
            let point = CGPoint(x: bounds.midX + xPos, y: bounds.midY + yPos)
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}

struct AdaptiveLayoutsView: View {
    @State private var currentLayout = 0
    @State private var count = 8
    let layouts = [AnyLayout(VStackLayout()), AnyLayout(HStackLayout()), AnyLayout(ZStackLayout()), AnyLayout(GridLayout())]
    var layout: AnyLayout {
        layouts[currentLayout]
    }
    
    
    var body: some View {
        RadialLayout {
            ForEach(0..<count, id: \.self) { _ in
                Circle()
                    .frame(width: 32, height: 32)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Stepper("Count: \(count)", value: $count.animation(), in: 0...36)
                .padding()
        }
        /*
        VStack {
            Spacer()
            layout {
                GridRow {
                    ExampleLayoutView(color: .red)
                    ExampleLayoutView(color: .green)
                }
                GridRow {
                    ExampleLayoutView(color: .blue)
                    ExampleLayoutView(color: .orange)
                }
            }
            Spacer()
            Button("Change Layout") {
                withAnimation {
                    currentLayout += 1
                    
                    if currentLayout == layouts.count {
                        currentLayout = 0
                    }
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
         */
    }
}

struct AdaptiveLayoutsView_Previews: PreviewProvider {
    static var previews: some View {
        AdaptiveLayoutsView()
    }
}
