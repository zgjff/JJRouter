//
//  JJRouterSource.swift
//  JJRouter
//
//  Created by zgjff on 2022/6/10.
//

import Foundation

/// 要匹配的路由来源
public protocol JJRouterSource {
    /// 注册的路由path
    var routerPattern: String { get }
    
    /// 注册路由
    func register() throws
    
    /// 生成与路由匹配的跳转路由目标
    func makeRouterDestination() -> JJRouterDestination
}

extension JJRouterSource {
    public func register() throws {
        return try JJRouter.default.register(pattern: routerPattern) { _ in
            return self
        }
    }
}
