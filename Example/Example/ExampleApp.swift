//
//  ExampleApp.swift
//  Example
//
//  Created by Dmitry Maslennikov on 20.06.2024.
//

import SwiftUI

@main
struct ExampleApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
