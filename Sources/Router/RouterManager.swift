//
//  RouterManager.swift
//  RouterDemo
//
//  Created by 郑桂杰 on 2022/7/13.
//

import Foundation

final class RouterManager {
    private var routes: Set<Route> = []
    private let scanner = Router.Scanner()
    init() {
        
    }
}

extension RouterManager {
    func register(pattern: String) throws {
        let tokens = scanner.tokenize(pattern: pattern)
        if tokens.isEmpty {
            throw RegisterRouteError.emptyPattern
        }
        let route = Route(tokens: tokens)
        let (success, member) = routes.insert(route)
        if !success {
            throw RegisterRouteError.alreadyExists(oldRoute: member)
        }
    }
}

extension RouterManager {
    enum RegisterRouteError: Error, CustomStringConvertible {
        case emptyPattern
        case alreadyExists(oldRoute: Route)
        
        var description: String {
            switch self {
            case .emptyPattern:
                return "格式为空"
            case .alreadyExists(let oldRoute):
                return "已经存在相同模式的路由: \(oldRoute)"
            }
        }
    }
}
