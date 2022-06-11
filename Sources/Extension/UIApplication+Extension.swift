//
//  UIApplication+Extension.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/11.
//

import UIKit

extension UIApplication {
    internal func topViewController(_ top: UIViewController?) -> UIViewController? {
        if let nav = top as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = top as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = top?.presentedViewController {
            return topViewController(presented)
        }
        return top
    }
    
    internal var version_keyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            let windows = UIApplication.shared.connectedScenes.compactMap { screen -> UIWindow? in
                guard let wc = screen as? UIWindowScene, wc.activationState == .foregroundActive else {
                    return nil
                }
                if let s = wc.delegate as? UIWindowSceneDelegate {
                    return s.window ?? nil
                }
                if #available(iOS 15.0, *) {
                    return wc.keyWindow
                } else {
                    return wc.windows.filter { $0.isKeyWindow }.first
                }
            }
            return windows.first
        }
        return keyWindow
    }
}
