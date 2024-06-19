//
//  AppDelegate.swift
//  Example
//
//  Created by Dmitry Maslennikov on 20.06.2024.
//

import Pulsar
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NetworkLogger.shared.prepare()
        return true
    }
}
