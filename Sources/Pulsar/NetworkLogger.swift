//
//  NetworkLogger.swift
//
//
//  Created by Dmitry Maslennikov on 19.06.2024.
//

import Pulse
import SwiftUI

public final class NetworkLogger {
    
    private let prepareAssertMessage = "You should use prepare() in didFinishLaunchingWithOptions"
    
    private(set) var isPrepared = false
    private(set) var isEnabled = false
    private(set) var isPresented = false {
        didSet {
            isPresented ? present() : dismiss()
        }
    }
    
    private var topViewController: UIViewController? {
        var rootViewController = UIWindow.keyWindow?.rootViewController
        while let controller = rootViewController?.presentedViewController {
            rootViewController = controller
        }
        return rootViewController
    }
    private var loggerNavigationController: UINavigationController?
    
    
    public static let shared = NetworkLogger()
    
    private init() { }
    
    public func prepare() {
        guard !isPrepared else { return }
        
        URLSessionProxyDelegate.enableAutomaticRegistration()
        Experimental.URLSessionProxy.shared.isEnabled = true
        
        isPrepared = true
    }
    
    public func enable() {
        assert(isPrepared, prepareAssertMessage)
        guard isPrepared, !isEnabled else { return }
        isEnabled = true
    }
    
    public func disable() {
        assert(isPrepared, prepareAssertMessage)
        guard isPrepared, isEnabled else { return }
        isEnabled = false
    }
    
    public func motionAction() {
        guard isPrepared, isEnabled else { return }
        isPresented.toggle()
    }
    
    private func present() {
        let loggerView = PulseView(dismissAction: dismissAction)
        let loggerController = UIHostingController(rootView: loggerView)
        let loggerNavigationController = UINavigationController(rootViewController: loggerController)
        loggerNavigationController.isModalInPresentation = true
        loggerNavigationController.navigationBar.prefersLargeTitles = true
        self.loggerNavigationController = loggerNavigationController
        topViewController?.present(loggerNavigationController, animated: true)
    }
    
    private func dismissAction() {
        isPresented = false
    }
    
    private func dismiss() {
        loggerNavigationController?.presentingViewController?.dismiss(animated: true)
        loggerNavigationController = nil
    }
}
