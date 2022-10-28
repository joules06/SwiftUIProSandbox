//
//  EqualWitdhLayoutView.swift
//  SwiftUIProDemo
//
//  Created by Julio Rico on 14/9/22.
//

import SwiftUI

struct EqualWitdhHStack: Layout {
    private func maximunSize(across subViews: Subviews) -> CGSize {
        var maximunSize = CGSize.zero
        
        for view in subViews {
            let size = view.sizeThatFits(.unspecified)
            
            if size.width > maximunSize.width {
                maximunSize.width = size.width
            }
            
            if size.height > maximunSize.height {
                maximunSize.height = size.height
            }
        }
        
        return maximunSize
    }
    
    private func spacing(for subviews: Subviews) -> [Double] {
        var spacing = [Double]()
        
        for index in subviews.indices {
            if index == subviews.count - 1 {
                spacing.append(0)
            } else {
                let distance = subviews[index].spacing.distance(to: subviews[index + 1].spacing, along: .horizontal)
                spacing.append(distance)
            }
        }
        
        return spacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxSize = maximunSize(across: subviews)
        let spacing = spacing(for: subviews)
        let totalSpace = spacing.reduce(0, +)
        
        return CGSize(width: maxSize.width * Double(subviews.count) + totalSpace, height: maxSize.height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let maxSize = maximunSize(across: subviews)
        let spacing = spacing(for: subviews)
        
        let proposal = ProposedViewSize(width: maxSize.width, height: maxSize.height)
        
        var x = bounds.minX + maxSize.width / 2
        
        for index in subviews.indices {
            subviews[index].place(at: CGPoint(x: x, y: bounds.midY), anchor: .center, proposal: proposal)
            x += maxSize.width + spacing[index]
        }
    }
}

struct EqualWitdhLayoutView: View {
    var body: some View {
        EqualWitdhHStack {
            Text("Short")
                .background(.red)
            
            Text("This text is long")
                .background(.green)
            
            Text("This is the longest text")
                .background(.blue)
        }
    }
}

struct EqualWitdhLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        EqualWitdhLayoutView()
    }
}
