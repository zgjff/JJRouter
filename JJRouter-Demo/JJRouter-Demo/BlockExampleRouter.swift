//
//  BlockExampleRouter.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/11.
//

import Foundation

enum BlockExampleRouter: String, CaseIterable, JJRouterSource {
    case bottomBlock = "/bottomBlock"
    case passContext = "/passContext"
    case passParameter = "/app/product/:id"
    case groupInfo = "/app/info/:id/:name"
}

extension BlockExampleRouter {
    var routerPattern: String {
        return self.rawValue
    }
}

extension BlockExampleRouter {
    func register() throws {
        try JJRouter.default.register(pattern: routerPattern, mapRouter: { result in
            guard case .passParameter = self else {
                return self
            }
            let needGotoLoginController = arc4random_uniform(2) == 0
            if needGotoLoginController {
                return SampleExampleRouter.login
            }
            return self
        })
    }
}

extension BlockExampleRouter {
    func makeRouterDestination() -> JJRouterDestination {
        switch self {
        case .bottomBlock: return BottomBlockExampleController()
        case .passContext: return PassContextBlockExampleController()
        case .passParameter: return PassParametersExampleController()
        case .groupInfo: return PassParametersExampleController()
        }
    }
}
