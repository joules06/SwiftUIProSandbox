//
//  EqualHeightLayoutView.swift
//  SwiftUIProDemo
//
//  Created by Julio Rico on 15/9/22.
//

import SwiftUI

struct EqualHeightHStack: Layout {
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
                let distance = subviews[index].spacing.distance(to: subviews[index + 1].spacing, along: .vertical)
                spacing.append(distance)
            }
        }
        
        return spacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxSize = maximunSize(across: subviews)
        let spacing = spacing(for: subviews)
        let totalSpace = spacing.reduce(0, +)
        
        return CGSize(width: maxSize.width, height: maxSize.height * Double(subviews.count) + totalSpace)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let maxSize = maximunSize(across: subviews)
        let spacing = spacing(for: subviews)
        
        let proposal = ProposedViewSize(width: maxSize.width, height: maxSize.height)
        
        var y = bounds.minY + maxSize.height / 2
        
        for index in subviews.indices {
            subviews[index].place(at: CGPoint(x: bounds.midX, y: y), anchor: .center, proposal: proposal)
            y += maxSize.height + spacing[index]
        }
    }
}


struct EqualHeightLayoutView: View {
    var body: some View {
        EqualHeightHStack {
            Text("Short")
                .background(.red)
            
            Text("This text\n is long")
                .background(.green)
            
            Text("This is\n the longest\n text")
                .background(.blue)
        }
    }
}

struct EqualHeightLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        EqualHeightLayoutView()
    }
}
