//
//  ContentView.swift
//  Example
//
//  Created by Dmitry Maslennikov on 20.06.2024.
//

import Pulsar
import SwiftUI

struct ContentView: View {
    
    @State
    private var isEnabled: Bool
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Toggle(
                    "Shake motion is enabled",
                    isOn: Binding(
                        get: { isEnabled },
                        set: { newState in
                            withAnimation {
                                updateIsEnabled(to: newState)
                            }
                        }
                    )
                )
                
                if isEnabled {
                    Text("Now you can shake to show/hide the logger console")
                        .foregroundStyle(.secondary)
                    
                    Text("Shake motion for a simulator: ⌃⌘Z")
                        .foregroundStyle(.secondary)
                    
                    Button("Manual shake motion", action: manualMotionAction)
                }
            }
            .padding()
            
            Button("Request for google.com", action: requestAction)
                .buttonStyle(.borderedProminent)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding()
        }
    }
    
    init() {
        _isEnabled = State(initialValue: true)
        NetworkLogger.shared.enable()
    }
    
    private func updateIsEnabled(to state: Bool) {
        isEnabled = state
        state ? NetworkLogger.shared.enable() : NetworkLogger.shared.disable()
    }
    
    private func manualMotionAction() {
        NetworkLogger.shared.motionAction()
    }
    
    private func requestAction() {
        Task {
            guard let url = URL(string: "https://www.google.com") else { return }
            let request = URLRequest(url: url)
            _ = try? await URLSession.shared.data(for: request)
        }
    }
}

#Preview {
    ContentView()
}
