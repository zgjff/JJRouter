//
//  UrlRouter.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/11.
//

import Foundation

extension URL: JJRouterSource {}

extension URL {
    public var routerPattern: String {
        return "/app/*"
    }
}

extension URL {
    public func register() throws {
        try JJRouter.default.register(pattern: routerPattern, mapRouter: { result in
            print("aaa----------", result)
            return nil
        })
    }
}

extension URL {
    public func makeRouterDestination() -> JJRouterDestination {
        return AlertCenterExampleController()
    }
}
