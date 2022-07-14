//
//  BlockExampleRouter.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/11.
//

import Foundation

enum BlockExampleRouter: JJRouterSource {
    case bottomBlock
    case passContext
    case passParameter
    case groupInfo(id: Int, name: String)
    
    static func register() {
//        let items: [BlockExampleRouter] = [BlockExampleRouter.bottomBlock, BlockExampleRouter.passContext, BlockExampleRouter.passParameter, BlockExampleRouter.groupInfo(id: 0, name: "")]
//        for item in items {
//            try? item.register()
//        }
//        try? BlockExampleRouter.bottomBlock.register()
        try? BlockExampleRouter.passParameter.register()
    }
}

extension BlockExampleRouter {
    var routerPattern: String {
        switch self {
        case .bottomBlock: return "/bottomBlock"
        case .passContext: return "/passContext"
        case .passParameter: return "/app/product/:id"
            // TODO: 参数应该像url一样拼接query
        case .groupInfo: return "/app/groupInfo/:id/:name"
        }
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
        case let .groupInfo:
//            print("lllllllll----", block())
            print("makeRouterDestination---------", self)
            return GroupInfoController(id: -999, name: "empty")
        }
    }
}
