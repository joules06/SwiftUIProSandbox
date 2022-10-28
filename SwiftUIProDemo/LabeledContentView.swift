//
//  LabeledContentView.swift
//  SwiftUIProDemo
//
//  Created by Julio Rico on 19/9/22.
//

import SwiftUI

struct VerticalLabeledContentStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content
        }
    }
}

extension LabeledContentStyle where Self == VerticalLabeledContentStyle {
    static var vertical: VerticalLabeledContentStyle { .init() }
}


struct LabeledContentView: View {
    var body: some View {
        Form {
            LabeledContent("Label", value: "Content")
                .labeledContentStyle(.vertical)
        }
    }
}

struct LabeledContentView_Previews: PreviewProvider {
    static var previews: some View {
        LabeledContentView()
    }
}
