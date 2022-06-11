//
//  SampleExampleRouter.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/11.
//

import Foundation

enum SampleExampleRouter: String, CaseIterable, JJRouterSource {
    case push = "/push"
    case systemPresent = "/systemPresent"
    case pushStylePresent = "/pushStylePresentExample"
    case alertCenter = "/alertCenter"
    case login = "/login"
}

extension SampleExampleRouter {
    var routerPattern: String {
        return self.rawValue
    }
}

extension SampleExampleRouter {
    func makeRouterDestination() -> JJRouterDestination {
        switch self {
        case .push: return PushExampleController()
        case .systemPresent: return SystemPresentExampleController()
        case .pushStylePresent: return PushStylePresentExampleController()
        case .alertCenter: return AlertCenterExampleController()
        case .login: return LoginController()
        }
    }
}
