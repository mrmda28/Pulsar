//
//  PulseView.swift
//
//
//  Created by Dmitry Maslennikov on 19.06.2024.
//

import PulseUI
import SwiftUI

struct PulseView: View {
    
    private let dismissAction: () -> Void
    
    var body: some View {
        ConsoleView()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "xmark")
                        .onTapGesture(perform: dismissAction)
                }
            }
    }
    
    init(dismissAction: @escaping () -> Void) {
        self.dismissAction = dismissAction
    }
}

#Preview {
    NavigationView {
        PulseView { }
    }
}
