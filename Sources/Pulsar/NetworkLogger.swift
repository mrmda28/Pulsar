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
    
    /// Prepares the logger for use. This method should be called in the AppDelegate's didFinishLaunchingWithOptions method.
    ///
    /// - Parameter forNative: A boolean flag that indicates whether the requests are performed
    ///   using a native framework. If `true`, the logger assumes that the requests are executed
    ///   via native frameworks (e.g., URLSession in iOS). If `false`, it indicates that the
    ///   requests are executed via non-native frameworks (e.g., Ktor from Kotlin Multiplatform).
    ///   When set to `false`, additional setup is performed to enable logging for non-native
    ///   frameworks. Defaults to `true`.
    ///
    /// This method ensures that the logger is prepared only once. If the logger is already prepared,
    /// subsequent calls to this method have no effect.
    ///
    /// - Note: When using a non-native framework like Ktor from Kotlin Multiplatform, set the
    ///   `forNative` parameter to `false` to enable automatic registration and proxy setup
    ///   required for proper logging.
    ///
    /// Example usage:
    /// ```
    /// // For native frameworks (e.g., URLSession)
    /// NetworkLogger.shared.prepare()
    ///
    /// // For non-native frameworks (e.g., Ktor)
    /// NetworkLogger.shared.prepare(forNative: false)
    /// ```
    public func prepare(forNative: Bool = true) {
        guard !isPrepared else { return }
        
        if !forNative {
            URLSessionProxyDelegate.enableAutomaticRegistration()
        }
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
