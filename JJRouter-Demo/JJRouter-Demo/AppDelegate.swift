//
//  AppDelegate.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if #available(iOS 13.0, *) {
            window?.backgroundColor = .systemBackground
        } else {
            window?.backgroundColor = .white
        }
        registerRouter()
        window?.rootViewController = UINavigationController(rootViewController: RootViewController())
        window?.makeKeyAndVisible()
        return true
    }
}

extension AppDelegate {
    private func registerRouter() {
//        SampleExampleRouter.allCases.forEach { try? $0.register() }
        BlockExampleRouter.register()
//        try? URL(string: "applinks://www.yourApp.com/app")?.register()
    }
}
