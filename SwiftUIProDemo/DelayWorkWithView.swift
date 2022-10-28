//
//  DelayWorkWithView.swift
//  SwiftUIProDemo
//
//  Created by Julio Rico on 16/10/22.
//

import SwiftUI

class DelayWorkWithViewViewModel: ObservableObject {
    private var refreshTask: Task<Void, Error>?
    var workCounter = 0
    
    func doWorkNow() {
        workCounter += 1
        print("Work done \(workCounter)")
    }
    
    func scheduleWork() {
        refreshTask?.cancel()
        
        refreshTask = Task {
            try await Task.sleep(until: .now + .seconds(3), clock: .continuous)
            doWorkNow()
        }
    }
}

struct DelayWorkWithView: View {
    @StateObject private var viewModel = DelayWorkWithViewViewModel()
    var body: some View {
        VStack {
            Button("Do work soon", action: viewModel.scheduleWork)
            Button("Do work now", action: viewModel.doWorkNow)
        }
    }
}

struct DelayWorkWithView_Previews: PreviewProvider {
    static var previews: some View {
        DelayWorkWithView()
    }
}
