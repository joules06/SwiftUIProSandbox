//
//  MultipleView.swift
//  SwiftUIProDemo
//
//  Created by Julio Rico on 28/10/22.
//

import SwiftUI

struct ExampleProperty {
    init(location: String) {
        print("Creating ExampleProperty from \(location)")
    }
}

struct ExampleModifier: ViewModifier {
    init(location: String) {
        print("Creating ExampleModifier from \(location)")
    }
    
    func body(content: Content) -> some View {
        print("In ExammpleModifier.body()")
        
        return content
    }
}

struct DetailMultipleView: View {
    @State private var property = ExampleProperty(location: "DetailView")
    
    var body: some View {
        print("In DetailView.body")
        return Text("Hello, world!")
            .modifier(ExampleModifier(location: "DetailView"))
            .task { print("In detail task") }
            .onAppear { print("In detail onAppear") }
    }
    
    init() {
        print("In DetailView.init")
    }
}

struct MultipleView: View {
    @State private var property = ExampleProperty(location: "MultipleView")
    
    var body: some View {
        print("In MultipleView.body")
        
        return NavigationLink("Hello world!") {
            DetailMultipleView()
        }
        .modifier(ExampleModifier(location: "ContentView"))
        .task { print("In first task.")}
        .task { print("In second task.")}
        .onAppear{ print("In first appear")}
        .onAppear{ print("In second appear")}
    }
    
    init() {
        print("In App.init")
    }
}

struct MultipleView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleView()
    }
}
