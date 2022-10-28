//
//  MultipleOnAppearView.swift
//  SwiftUIProDemo
//
//  Created by Julio Rico on 27/10/22.
//

import SwiftUI

struct OnFirstAppearModifier: ViewModifier {
    @State private var hasLoaded = false
    var perform: () -> Void
    
    func body(content: Content) -> some View {
        content.onAppear {
            guard hasLoaded == false else { return }
            hasLoaded = true
            perform()
        }
    }
}

extension View {
    func onFirstAppear(perform: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearModifier(perform: perform))
    }
}

struct ExmapleView: View {
    let number: Int
    
    var body: some View {
        Text("View \(number)")
            .onFirstAppear {
                print("View \(number) appearing")
            }
    }
}

struct MultipleOnAppearView: View {
    var body: some View {
        TabView {
            ForEach(1..<6) { i in
                ExmapleView(number: i)
                    .tabItem {
                        Label(String(i), systemImage: "\(i).circle")
                    }
            }
        }
    }
}

struct MultipleOnAppearView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleOnAppearView()
    }
}
