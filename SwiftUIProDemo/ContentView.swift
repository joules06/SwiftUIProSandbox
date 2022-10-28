//
//  ContentView.swift
//  SwiftUIProDemo
//
//  Created by Julio Rico on 12/9/22.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
