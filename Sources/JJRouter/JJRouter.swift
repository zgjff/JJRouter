//
//  JJRouter.swift
//  JJRouter
//
//  Created by zgjff on 2022/6/10.
//

import Foundation
import RouterX
import UIKit

/// 路由管理
public final class JJRouter {
    public typealias MatchedHandler = (MatchResult) -> Void
    public typealias UnmatchHandler = ((URL, _ context: Any?) -> Void)

    /// 默认的路由管理
    public static let `default` = JJRouter { url, context in
        debugPrint("⚠️⚠️⚠️JJRouter 未匹配到 url: \(url), context: \(String(describing: context))")
    }
    
    /// app的`KeyWindow`,如果感觉框架提供的`version_keyWindow`有问题的话,你可以提供自己实现的`appKeyWindow`
    ///
    /// 用来获取app的最顶层的控制器
    public var appKeyWindow: UIWindow? = UIApplication.shared.version_keyWindow
    
    private let core: RouterXCore = RouterXCore()
    private let defaultUnmatchHandler: UnmatchHandler?

    private var handlerMappings: [PatternIdentifier: MatchedHandler] = [:]
    public init(defaultUnmatchHandler: UnmatchHandler? = nil) {
        self.defaultUnmatchHandler = defaultUnmatchHandler
    }
}

// MARK: - register
extension JJRouter {
    /// 注册路由
    /// - Parameters:
    ///   - pattern: 路由path
    ///   - mapRouter: 映射匹配到的路由来源----给匹配到路由时,最后决定跳转的策略
    public func register(pattern: String, mapRouter: @escaping (MatchResult) -> JJRouterSource?) throws {
        try core.register(pattern: pattern)
        handlerMappings[pattern] = { result in
            guard let mrd = mapRouter(result) else {
                return
            }
            let destView = mrd.makeRouterDestination()
            destView.deal(withMatchedResult: result)
        }
    }
}

// MARK: - open
extension JJRouter {
    /// 匹配泛型`JJRouterSource`并跳转路由
    /// - Parameters:
    ///   - source: 路由来源
    ///   - context: 传递给匹配到的路由界面数据
    /// - Returns: 匹配结果
    @discardableResult
    func open<T>(_ source: T, context: Any? = nil, unmatchHandler: UnmatchHandler? = nil) -> JJRouter.MatchResult? where T: JJRouterSource {
        return open(source.routerPattern, context: context, unmatchHandler: unmatchHandler)
    }
    
    /// 匹配泛型`path`并跳转路由
    /// - Parameters:
    ///   - source: 路由来源
    ///   - context: 传递给匹配到的路由界面数据
    /// - Returns: 匹配结果
    @discardableResult
    public func open(_ path: String, context: Any? = nil, unmatchHandler: UnmatchHandler? = nil) -> JJRouter.MatchResult? {
        guard let url = URL(string: path) else {
            return nil
        }
        return open(url, context: context, unmatchHandler: unmatchHandler)
    }
    
    /// 匹配泛型`URL`并跳转路由
    /// - Parameters:
    ///   - source: 路由来源
    ///   - context: 传递给匹配到的路由界面数据
    /// - Returns: 匹配结果
    @discardableResult
    public func open(_ url: URL, context: Any? = nil, unmatchHandler: UnmatchHandler? = nil) -> JJRouter.MatchResult? {
        guard let matchedRoute = core.match(url) else {
            let expectUnmatchHandler = unmatchHandler ?? defaultUnmatchHandler
            expectUnmatchHandler?(url, context)
            return nil
        }
        guard let matchHandler = handlerMappings[matchedRoute.patternIdentifier] else {
                let expectUnmatchHandler = unmatchHandler ?? defaultUnmatchHandler
                expectUnmatchHandler?(url, context)
                return nil
        }
        let result = JJRouter.MatchResult(url: url, parameters: matchedRoute.parametars, context: context)
        matchHandler(result)
        return result
    }
}

// MARK: - CustomDebugStringConvertible, CustomStringConvertible
extension JJRouter: CustomDebugStringConvertible, CustomStringConvertible {
    public var description: String {
        return self.core.description
    }

    public var debugDescription: String {
        return self.description
    }
}
