//
//  AssertAutorefreshingView.swift
//  SwiftUIProDemo
//
//  Created by Julio Rico on 27/10/22.
//

import SwiftUI

extension View {
    public func assert(
        _ condition: @autoclosure () -> Bool,
        _ message: @autoclosure () -> String = String(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> some View {
        Swift.assert(condition(), message(), file: file, line: line)
        return self
    }
}

struct AssertAutorefreshingView: View {
    @State private var counter = 0
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text("Example View Here")
            .onReceive(timer) { _ in
                counter += 1
            }
            .assert(counter < 50, "Timer exceeded")
    }
}

struct AssertAutorefreshingView_Previews: PreviewProvider {
    static var previews: some View {
        AssertAutorefreshingView()
    }
}
