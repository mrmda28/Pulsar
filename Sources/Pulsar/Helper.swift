//
//  Helper.swift
//
//
//  Created by Dmitry Maslennikov on 19.06.2024.
//

import UIKit

public extension UIWindow {
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        NetworkLogger.shared.motionAction()
    }
}

extension UIWindow {
    
    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .sorted { $0.activationState.sortPriority < $1.activationState.sortPriority }
            .compactMap { $0 as? UIWindowScene }
            .compactMap { $0.windows.first { $0.isKeyWindow } }
            .first
    }
}

private extension UIScene.ActivationState {
    
    var sortPriority: Int {
        switch self {
        case .foregroundActive: 1
        case .foregroundInactive: 2
        case .background: 3
        case .unattached: 4
        @unknown default: 5
        }
    }
}
