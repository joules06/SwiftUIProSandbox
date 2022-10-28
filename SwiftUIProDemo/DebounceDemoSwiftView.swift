//
//  DebounceDemoSwiftView.swift
//  SwiftUIProDemo
//
//  Created by Julio Rico on 9/10/22.
//
import Combine
import SwiftUI

class Debouncer<T>: ObservableObject {
    @Published var input: T
    @Published var output: T
    
    private var textDebounce: AnyCancellable?
    
    init(initialValue: T, delay: Double = 1) {
        self.input = initialValue
        self.output = initialValue
        textDebounce = $input
            .debounce(for: .seconds(delay), scheduler:
                        DispatchQueue.main)
            .sink { [weak self] in
                self?.output = $0
            }
    }
}

struct DebounceDemoSwiftView: View {
    @State private var text = Debouncer(initialValue: "", delay: 0.5)
    @State private var slider = Debouncer(initialValue: 0.0, delay: 0.1)
    var body: some View {
        VStack {
            TextField("Search for something", text: $text.input)
                .textFieldStyle(.roundedBorder)
            Text(text.output)
            
            Spacer().frame(height: 50)
            
            Slider(value: $slider.input, in: 0...100)
            Text(slider.output.formatted())
        }
    }
}

struct DebounceDemoSwiftView_Previews: PreviewProvider {
    static var previews: some View {
        DebounceDemoSwiftView()
    }
}
