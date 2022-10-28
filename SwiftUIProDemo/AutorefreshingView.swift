//
//  AutorefreshingViw.swift
//  SwiftUIProDemo
//
//  Created by Julio Rico on 27/10/22.
//

import SwiftUI

class AutorefreshingObject: ObservableObject {
    var timer: Timer?
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.objectWillChange.send()
        }
    }
}

extension ShapeStyle where Self == Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

struct AutorefreshingView: View {
//    @StateObject private var viewModel = AutorefreshingObject()
    
    var body: some View {
        let _ = Self._printChanges()
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding()
            .background(.random)
    }
}

struct AutorefreshingView_Previews: PreviewProvider {
    static var previews: some View {
        AutorefreshingView()
    }
}
